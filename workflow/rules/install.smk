WRF_REPO = "git@github.com:Urban-M4/WRF.git"
PARALLEL_OPTIONS = {
    "dm": "-DUSE_MPI=ON -DUSE_OPENMP=OFF",
    "sm": "-DUSE_MPI=OFF -DUSE_OPENMP=ON",
    "hybrid": "-DUSE_MPI=ON -DUSE_OPENMP=ON",
    "serial": "-DUSE_MPI=OFF -DUSE_OPENMP=OFF",
}


rule CLONE_WRF:
    output: "WRF/.git",
    shell: f"git clone --recurse-submodules {WRF_REPO}"


rule COMPILE_WRF_LATEST:
    input: "WRF/.git",
    output: "WRF/install/latest/gnu/{parallel_opt}/run/wrf",
    params:
        parallel=lambda wildcards: PARALLEL_OPTIONS[wildcards.parallel_opt],
        build_dir=lambda wildcards: f"_build_latest_gnu_{wildcards.parallel_opt}",
    shell: 
        """
        cd WRF
        git checkout master
        git pull

        # build dir must be flat because of `cd ..` in ./configure_new
        # install dir may be nested and is relative to build dir
        ./configure_new -p GNU -d {params.build_dir} -i ../install/latest/gnu/{wildcards.parallel_opt} -x -- {params.parallel} -DWRF_NESTING=BASIC
        
        # Run compilation on a staging node but interactively so snakemake can wait for it to complete. 
        srun -p staging -n 1 -t 1:00:00 --pty ./compile_new {params.build_dir} -j 1
        """