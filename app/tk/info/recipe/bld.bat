if "%ARCH%"=="32" (
   set MACHINE="IX86"
) else (
  set MACHINE="AMD64"
)

REM Get tcl sources
curl -L -o tcl%PKG_VERSION%.tar.gz "http://sourceforge.net/projects/tcl/files/Tcl/%PKG_VERSION%/tcl%PKG_VERSION%-src.tar.gz/download"
7za x -so tcl%PKG_VERSION%.tar.gz | 7za x -si -aoa -ttar


REM Required for having tmschema.h accessible.  Newer VS versions do not include this.
REM If you don't have this path, you are missing the Windows 7 SDK.  Please install this.
REM   NOTE: Later SDKs remove tmschema.h.  It really is necessary to use the Win 7 SDK.
set INCLUDE=%INCLUDE%;c:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include

cd win
nmake -f makefile.vc all install INSTALLDIR=%LIBRARY_PREFIX% MACHINE=%MACHINE% TCLDIR=%SRC_DIR%\tcl%PKG_VERSION% LIBRARY_LIB=%LIBRARY_LIB%
if %ERRORLEVEL% GTR 0 exit 1
