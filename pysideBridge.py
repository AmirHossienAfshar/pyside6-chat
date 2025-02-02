from PySide6.QtCore import QObject, Property, Signal, Slot
import threading

class Bridge(QObject):
    def __init__(self):
        super().__init__()
        self.msgDict = {
            "mymsg": "hi",
            "othermsg": "hello! how you doin?",
            "mymsg": "pretty well!"
            }
        t = threading.Thread(target=self.main_func)
        t.start()
        
    msgDict_changed = Signal()
        
    def set_msgDict(self, value):
        print(f"[PYSIDE] the value to set is {value}")
        self.msgDict = value
        self.msgDict_changed.emit
        
    def get_msgDict(self):
        return self.msgDict
    
    pyside_chat_data = Property(dict, get_msgDict, set_msgDict, notify=msgDict_changed)
    
    
    def main_func(self):
        print("setting the values!")
        self.set_msgDict({"mymsg": "hi",
            "othermsg": "hello! how you doin?",
            "mymsg": "pretty well!"})
        
        
    