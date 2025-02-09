from PySide6.QtCore import QObject, Property, Signal, Slot
from datetime import datetime
import pyperclip
from pysideBridge import Bridge

class MessageMenu(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.bridge = Bridge.get_instance()
        
    @Slot(str)
    def menu_copy_msg(self, value):
        pyperclip.copy(value)

    @Slot(str)
    def menu_edith_msg(self, value):
        self.bridge.set_is_edithing(True)
        self.bridge.set_edithing_text(value)
        
    @Slot(int)
    def menu_edith_msg_index(self, value):
        self.bridge.set_edithing_index(value)
        
    @Slot(str)
    def menu_edith_msg_time(self, value):
        self.bridge.edithing_msg_time = value
        
    @Slot(int)
    def menu_delete_msg(self, value):
        # print(f"[PYSIDE] msg to delete is {value}")
        try:
            del self.bridge.msgList[value]
            self.bridge.msgList_changed.emit()
        except IndexError:
            print(f"[PYSIDE] Index {value} is out of range for msgList")