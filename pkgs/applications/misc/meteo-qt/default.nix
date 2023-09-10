{ lib
, fetchFromGitHub
, python3
, qttranslations
, qttools
, qtbase
, wrapQtAppsHook
, libxml2
}:

python3.pkgs.buildPythonApplication rec {
  pname = "meteo-qt";
  version = "3.3";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "dglent";
    repo = "meteo-qt";
    rev = "v${version}";
    hash = "sha256-Gy+k6rJ10ow1pFXjkHFxw5jcYsLMAu58HiuHLmh+MAw=";
  };

  # propagatedBuildInputs = with python3.pkgs; [
  #   lxml
  #   pyqt5
  #   qt5-tools
  #   sip
  # ];
  propagatedBuildInputs = with python3.pkgs; [
    # buildInputs = with python3.pkgs; [
    # lxml
    pyqt5
    sip_4
    urllib3
    setuptools
    pyqt5_sip
  ] ++ [
    qttranslations
    qtbase
    qttools
    # meteo-qt
    libxml2
  ];

  nativeBuildInputs = [
    python3.pkgs.pyqt5
    wrapQtAppsHook
    # pkg-config
    qttools
  ];
  # nativeCheckInputs = [
  #     qttools
  # ];
  dontWrapQtApps = false;

    # python setup.py install --root $out
    # python setup.py install --home $out
      # --install-lib=$out/lib/${python3.libPrefix}/site-packages \

      # --install-lib $out \
      # --install-headers $out \
      # --install-scripts $out \
      # --install-data $out \
      # --prefix $out \
  installPhase = ''
    echo "OUT $out OUT"
    python setup.py install \
      --root $out
  '';
  doCheck = false;

  # pythonImportsCheck = [ "meteo_qt" ];

  meta = with lib; {
    description = "System tray application for weather status information";
    homepage = "https://github.com/dglent/meteo-qt";
    changelog = "https://github.com/dglent/meteo-qt/blob/${src.rev}/CHANGELOG";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
  };
}
