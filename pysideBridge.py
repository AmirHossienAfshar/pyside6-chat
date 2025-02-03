from PySide6.QtCore import QObject, Property, Signal, Slot
import threading

class Bridge(QObject):
    def __init__(self):
        super().__init__()
        self.msgList = []
        
        t = threading.Thread(target=self.main_func)
        t.start()
        
    msgList_changed = Signal()
    
    def set_msgList(self, value):
        # print(f"[PYSIDE] the value to set is {value}")
        self.msgList = value
        self.msgList_changed.emit
        
    def get_msgList(self):
        return self.msgList
    
    pyside_chat_list = Property(list, get_msgList, set_msgList, notify=msgList_changed)
    
    
    def main_func(self):
        print("setting the values!")
        # self.set_msgDict({"mymsg": "hi",
        #     "othermsg": "hello! how you doin?",
        #     "mymsg": "pretty well!"})
        # self.set_msgList(["hello!", "hi!", "how you doing?", "im ok~!"])
        test_dict = [
            "mine: Hey, how are you?",
            "other: I'm good! How about you?",
            "mine: Doing great! Just finished a project.",
            "other: Oh nice! What was it about?",
            "mine: It was a chatbot for customer service.",
            "other: Sounds interesting! Was it difficult?",
            "mine: A bit, but I learned a lot.",
            "other: That's awesome! What tech did you use?",
            "mine: Python and some QML for UI.",
            "other: Cool! Are you planning to expand it?",
            "mine: Yeah, thinking of adding voice recognition.",
            "other: That would be amazing!",
            "mine: For sure! Any projects you're working on?",
            "other: Just learning more about machine learning.",
            "mine: Oh, nice! Any specific focus?",
            "other: NLP, I want to work on chatbots too!",
            "mine: Awesome! We should collaborate sometime.",
            "other: Absolutely! Let's plan something.",
            "mine: Sounds good! I’ll send some ideas over.",
            "other: Looking forward to it!"
        ]
        self.set_msgList(test_dict)

        
        
    