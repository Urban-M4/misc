# Some notes while editing/debugging fortran code

* Install `modern fortran` plugin in vscode, and make sure that the language server is working
* Source files in geogrid have extension `.F`, which suggests that its fixed-format fortran (77), but it isn't. On the bottom right, click on the `fortran` language, and select `Configure file associate for `.F` and set it to 'normal' fortran.
* Language server should be installed automatically, but it wasn't for me. Run `pip install fortls; which fortls` and copy the path into vscode settings (search in settings for fortls; you'll find `fortls path`)
* To insert debug statements in fortran, can use `print*,'my debug statement` and recompile
* See WRF contributing guidlines [here](https://www2.mmm.ucar.edu/wrf/users/code_contribution/contrib_info.php) (with many links to other resources in it)
* Changes from SITC: https://github.com/summerinthecity/wrf-wur/compare/d374f81...e784d84