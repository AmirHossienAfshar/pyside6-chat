from PySide6.QtCore import QObject, Property, Signal, Slot
from datetime import datetime
import pyperclip
from pysideBridge import Bridge

class MessageMenu(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.bridge = Bridge.get_instance()  # Get the shared Bridge instance
        
    @Slot(str)
    def menu_copy_msg(self, value):
        pyperclip.copy(value)
        
    @Slot(str)
    def menu_edith_msg(self, value):
        # self.bridge.edith_option_text = value
        self.bridge.set_edithing_text(value)
        
    @Slot(str)
    def menu_delete_msg(self, value):
        print(f"[PYSIDE] msg to delete is {value}")
        for msg in self.bridge.msgList:
            if msg.endswith(value):
                self.bridge.msgList.remove(msg)
                break
        self.bridge.msgList_changed.emit()
        
        
        
    # @Slot(str)
    # def menu_copy_msg(self, value):
    #     pyperclip.copy(value)
    #     # print(f"[PYSIDE] msg cipied to clipboard! value is {value}")
        
    # @Slot(str)
    # def menu_edith_msg(self, value):
    #     pass                
        
    # @Slot(str)
    # def menu_delete_msg(self, value):
    #     print(f"[PYSIDE] msg to delete is {value}")
    #     for msg in self.msgList:
    #         if msg.endswith(value):
    #             self.msgList.remove(msg)
    #             break
    #     # print(self.msgList)
    #     self.msgList_changed.emit()