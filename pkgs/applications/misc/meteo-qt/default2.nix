{ callPackage
, lib
, stdenv
, testVersion
  # , mkDerivation
, makeDesktopItem
, fetchFromGitHub
, wrapQtAppsHook
, pkg-config
  # , python-lxml
  # , python-pyqt5
  # , python-sip4
  # , python-urllib3
  # , buildPythonApplication
, python3
, qttranslations
, qttools
, qtbase
}:

# stdenv.mkDerivation rec {
# buildPythonApplication rec {
# let
#   myPython = python3.withPackages (pkgs: with pkgs; [ pyqt5 lxml sip_4 urllib3 ]);
# in

# python3.pkgs.buildPythonApplication rec {
python3.pkgs.buildPythonPackage rec {
  # mkDerivation rec {
  pname = "meteo-qt";
  version = "3.3";

  propagatedBuildInputs = with python3.pkgs; [
    # buildInputs = with python3.pkgs; [
    lxml
    pyqt5
    sip_4
    urllib3
    setuptools
  ] ++ [
    qttranslations
    qtbase
    qttools
    # meteo-qt
  ];
  # checkInputs = [qttools];
  # propagatedBuildInputs = [qttools];

  # buildInputs = [
  #     python3.pkgs.pyqt5
  #     qttools
  #     # qtbase
  #     # qttools
  #     # pkg-config
  #     # python3Packages.lxml
  #     # python-pyqt5
  #     # python-sip4
  #     # python-urllib3
  #     # buildPythonApplication
  # ];
  nativeBuildInputs = [
    wrapQtAppsHook
    # pkg-config
    qttools
  ];
  # nativeCheckInputs = [
  #     qttools
  # ];
  dontWrapQtApps = false;

  # mkdir -p $out/bin
  # cp foo $out/bin
  # cd $pkgname-$pkgver
  # python setup.py install --root $pkgdir
  # python setup.py install
  # echo $PATH
  # lrelease
  LRELEASE = "${qttools.dev}/bin/lrelease";
  preConfigure = ''
    export lrelease=${lib.getDev qttools}/bin/lrelease
  '';
  format = "other";
  # ${python3.interpreter} setup.py install --root $out

  postPatch = ''
    substituteInPlace setup.py \
    --replace "lrelease" "${qttools.dev}/bin/lrelease" \
    --replace "pylupdate5" "${python3.pkgs.pyqt5}/bin/pylupdate5" \
  '';
  # makeWrapperArgs = ["--set FOO BAR" "--set BAZ QUX"];
  # lrelease
  # PYTHONPATH=$out/${python3.sitePackages}:$PYTHONPATH
  installPhase = ''
            runHook preInstall
                echo $LRELEASE
                python setup.py install --root $out
                         echo HELLO
        echo $PYTHONPATH
            PYTHONPATH=$out/${python3.sitePackages}/meteo-qt:$PYTHONPATH
            PYTHONPATH=$out/${python3.pkgs.lxml}/:$PYTHONPATH


    runHook postInstall

  '';
  # mv $out/${python3.sitePackages} $out/bin

  # preFixup = ''
  #   makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  # '';

  postCheck = ''
    echo HELLO
    echo $PYTHONPATH
    PYTHONPATH=$out/${python3.sitePackages}/meteo-qt:$PYTHONPATH
    echo $PYTHONPATH
  '';
  # preFixup = ''
  #     chmod 555 $out/bin/meteo-qt
  #     wrapQtApp $out/bin/meteo-qt
  #   '';

  doCheck = false;

  meta = with lib; {
    description = "System tray application for weather status information";
    homepage = "https://github.com/dglent/meteo-qt";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.m ];
  };

  #  src = fetchFromGitHub {
  #   owner = "mhogomchungu";
  #   repo = "sirikali";
  #   rev = "v${version}";
  #   sha256 = "0s518m9hwb6b1d9ircn39lhy4vplaxk7j924igky5kxq47zn0jj8";
  # };

  src = fetchFromGitHub {
    owner = "dglent";
    repo = "meteo-qt";
    rev = "v3.3";
    hash = "sha256-Gy+k6rJ10ow1pFXjkHFxw5jcYsLMAu58HiuHLmh+MAw=";
  };

}

