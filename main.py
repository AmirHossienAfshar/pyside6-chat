import sys
from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from pysideBridge import Bridge
import os

if __name__ == "__main__":
    
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    qml_file = os.path.join(script_dir, "main.qml")  
    
    qmlRegisterType(Bridge, "Pyside_Bridge", 1, 0, "Pyside_Bridge_class")
    
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()
    engine.load(qml_file)
    
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())