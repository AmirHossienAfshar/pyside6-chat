from PySide6.QtCore import QObject, Property, Signal, Slot
import threading
from datetime import datetime

class Bridge(QObject):
    msgList_changed = Signal()
    
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
        self.edith_option_text = "some random text///////////////////////"
        self.is_edithing = False
        
        t = threading.Thread(target=self.main_func, daemon=True)
        t.start()
        
    def set_msgList(self, value):
        # print(f"[PYSIDE] the value to set is {value}")
        self.msgList = value
        # self.msgList.append(value)
        self.msgList_changed.emit()
        print("msgList_changed signal emitted")
        
    def get_msgList(self):
        return self.msgList
            
    pyside_chat_list = Property(list, get_msgList, set_msgList, notify=msgList_changed)
    
    def get_edithing_text(self):
        # print("getting the edithing text")
        return self.edith_option_text
    
    def set_edithing_text(self, value):
        # print("setting the edithing text")
        self.edith_option_text = value
        self.edithing_text_changed.emit()
        
    edithing_text_changed = Signal()
    pyside_edithing_text = Property(str, get_edithing_text, set_edithing_text, notify=edithing_text_changed)
    
    def get_is_edithing(self):
        # print("getting the edithing text")
        return self.is_edithing
    
    def set_is_edithing(self, value):
        # print("setting the edithing text")
        self.is_edithing = value
        self.is_edithing_changed.emit()
        
    is_edithing_changed = Signal()
    pyside_is_edithing = Property(bool, get_is_edithing, set_is_edithing, notify=is_edithing_changed)

    @Slot(str)
    def set_new_msg(self, value):
        now = datetime.now()
        current_hour = now.hour
        current_min = now.minute
        msg = "THIS#time#" + str(current_hour) + ":" + str(current_min) + "# " + value 
        self.msgList.append(msg)
        self.msgList_changed.emit()
        # print(self.msgList)
    
    def main_func(self):
        print("setting the values!")

        self.msgList = [
            "THIS#time#09:18# Hey, how are you?",
            "THAT#time#09:20# I'm good! How about you?",
            "THIS#time#09:30# Doing great! Just finished a project.",
            "THAT#time#09:37# Oh nice! What was it about?",
            "THIS#time#09:42# It was a chatbot for customer service.",
            "THIS#time#09:52# Two messages in a row",
            "THAT#time#09:55# Sounds interesting! Was it difficult?",
            "THIS#time#09:57# A bit, but I learned a lot.",
            "THAT#time#10:06# That's awesome! What tech did you use?",
            "THIS#time#10:09# Python and some QML for UI.",
        ]
        self.set_msgList(self.msgList)
        print("values are now setted")
        
        # # this below code is oddly not working!!
        # start_time = datetime.strptime(f"{random.randint(8, 10)}:{random.randint(0, 59)}", "%H:%M")

        # test_messages = [
        #     "THIS#time# Hey, how are you?",
        #     "THAT#time# I'm good! How about you?",
        #     "THIS#time# Doing great! Just finished a project.",
        #     "THAT#time# Oh nice! What was it about?",
        #     "THIS#time# It was a chatbot for customer service.",
        #     "THIS#time# Two messages in a row",
        #     "THAT#time# Sounds interesting! Was it difficult?",
        #     "THIS#time# A bit, but I learned a lot.",
        #     "THAT#time# That's awesome! What tech did you use?",
        #     "THIS#time# Python and some QML for UI.",
        # ]

        # test_dict = []
        # current_time = start_time

        # for msg in test_messages:
        #     timestamp = current_time.strftime("%H:%M")
        #     formatted_msg = msg.replace("time#", f"time#{timestamp}#")
        #     test_dict.append(str(formatted_msg))
        #     current_time += timedelta(minutes=random.randint(1, 10))
            
        # print(test_dict)
            
        # self.set_msgList(test_dict)

        # test_dict = [
        #     "mine: Hey, how are you?",
        #     "other: I'm good! How about you?",
        #     "mine: Doing great! Just finished a project.",
        #     "other: Oh nice! What was it about?",
        #     "mine: It was a chatbot for customer service.",
        #     "other: Sounds interesting! Was it difficult?",
        #     "mine: A bit, but I learned a lot.",
        #     "other: That's awesome! What tech did you use?",
        #     "mine: Python and some QML for UI.",
        #     "other: Cool! Are you planning to expand it?",
        #     "mine: Yeah, thinking of adding voice recognition.",
        #     "other: That would be amazing!",
        #     "mine: For sure! Any projects you're working on?",
        #     "other: Just learning more about machine learning.",
        #     "mine: Oh, nice! Any specific focus?",
        #     "other: NLP, I want to work on chatbots too!",
        #     "mine: Awesome! We should collaborate sometime.",
        #     "other: Absolutely! Let's plan something.",
        #     "mine: Sounds good! I’ll send some ideas over.",
        #     "other: Looking forward to it!"
        # ]
        # self.set_msgList(test_dict)