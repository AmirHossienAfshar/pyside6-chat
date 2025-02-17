from PySide6.QtCore import QObject, Property, Signal, Slot
import threading
from datetime import datetime
from client import Client

class Bridge(QObject):
    msgList_changed = Signal()
    edithing_text_changed = Signal()
    is_edithing_changed = Signal()
    edithing_index_changed = Signal()
    chat_target_changed = Signal()
    contact_list_changed = Signal()
    
    _instance = None  # Singleton instance
    
    @classmethod
    def get_instance(cls):
        """Returns the singleton instance of Bridge."""
        if cls._instance is None:
            cls._instance = Bridge()
        return cls._instance
    
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
    
    def __init__(self):
        if hasattr(self, "_initialized"):  # Prevent multiple initializations
            return
        super().__init__()
        self.msgList = []
        self._initialized = True
        self.edith_option_text = ""
        self.is_edithing = False
        self.edith_msg_index = -1
        self.edithing_msg_time = ""
        self.is_current_msg_edith_flag = "0"
        self.chat_target = "reza"
        self.contact_list = ['amir', 'hasan', 'hossein']
        
        t = threading.Thread(target=self.main_func, daemon=True)
        t.start()
        
    def set_msgList(self, value):
        self.msgList = value
        self.msgList_changed.emit()
        
    def get_msgList(self):
        return self.msgList
    
    def get_edithing_text(self):
        return self.edith_option_text
    
    def set_edithing_text(self, value):
        self.edith_option_text = value
        self.edithing_text_changed.emit()
    
    def get_is_edithing(self):
        return self.is_edithing
    
    def set_is_edithing(self, value):
        self.is_edithing = value
        self.is_edithing_changed.emit()
    
    def get_edithing_index(self):
        return self.edith_msg_index
    
    def set_edithing_index(self, value):
        self.edith_msg_index = value
        self.edithing_index_changed.emit()
            
    def get_chat_target(self):
        return self.chat_target
    
    def set_chat_target(self, value):
        self.chat_target = value
        self.chat_target_changed.emit()
        
    def get_contact_list(self):
        return self.contact_list
    
    def set_contact_list(self, value):
        self.contact_list = value
        self.contact_list_changed.emit()
        
    pyside_contact_list = Property(list, get_contact_list, set_contact_list, notify=contact_list_changed)
    pyside_chat_target = Property(str, get_chat_target, set_chat_target, notify=chat_target_changed)
    pyside_chat_list = Property(list, get_msgList, set_msgList, notify=msgList_changed)
    pyside_edithing_text = Property(str, get_edithing_text, set_edithing_text, notify=edithing_text_changed)
    pyside_is_edithing = Property(bool, get_is_edithing, set_is_edithing, notify=is_edithing_changed)
    pyside_edithing_index = Property(int, get_edithing_index, set_edithing_index, notify=edithing_index_changed)

    @Slot(str)
    def set_new_msg(self, value):
        now = datetime.now()
        current_hour = now.hour
        current_min = now.minute
        msg = "THIS#time#" + str(current_hour) + ":" + str(current_min) + "#0# " + value # 0 is for the not edithed msg
        self.msgList.append(msg)
        self.msgList_changed.emit()
        
    @Slot(str)
    def edith_msg(self, value):
        msg = "THIS#time#" + self.edithing_msg_time + "#1# " + value
        self.msgList[self.edith_msg_index] = msg
        self.msgList_changed.emit()
        self.set_is_edithing(False)
        self.set_edithing_index(-1)
        self.edithing_msg_time = ""
    
    def main_func(self):
        # print("setting the values!")
        self.msgList = [
            "THIS#time#09:18#0# Hey, how are you?",
            "THAT#time#09:20#0# I'm good! How about you?",
            "THIS#time#09:30#0# Doing great! Just finished a project.",
            "THAT#time#09:37#0# Oh nice! What was it about?",
            "THIS#time#09:42#0# It was a chatbot for customer service.",
            "THIS#time#09:52#0# Two messages in a row",
            "THAT#time#09:55#0# Sounds interesting! Was it difficult?",
            "THIS#time#09:57#0# A bit, but I learned a lot.",
            "THAT#time#10:06#0# That's awesome! What tech did you use?",
            "THIS#time#10:09#0# Python and some QML for UI.",
        ]
        self.set_msgList(self.msgList)
        
        self.set_contact_list(['amir', 'hasan', 'hossein', 'ali', 'reza'])