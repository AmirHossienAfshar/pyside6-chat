import socket
import threading

class Server:
    def __init__(self, host="127.0.0.1", port=5050):
        self.host = host
        self.port = port
        self.format = "utf-8"
        self.addr = (self.host, self.port)
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.active_users = {}

    def start(self):
        self.server.bind(self.addr)
        self.server.listen()
        print(f"[LISTENING] Server is running on {self.host}:{self.port}")
        while True:
            client_conn, client_addr = self.server.accept()
            thread = threading.Thread(target=self.client_handle, args=(client_conn,))
            thread.start()
            print(f"[ACTIVE CONNECTIONS] {threading.active_count() - 1}")

    def client_handle(self, conn):
        print("[NEW CLIENT] Waiting for username...")

        try:
            username = conn.recv(1024).decode(self.format)
            if username:
                self.active_users[username] = conn
                print(f"[NEW USER] {username} has joined")
                conn.send(f"Welcome to the chat server {username}!".encode(self.format))
        except Exception as e:
            print(f"[ERROR] Could not retrieve username: {e}")
            conn.close()
            return

        connected = True
        while connected:
            try:
                msg = conn.recv(1024).decode(self.format)
                if not msg:
                    break
                if msg == "DISCONNECT":
                    print(f"[DISCONNECT] {username} disconnected")
                    self.active_users.pop(username, None)
                    connected = False
                elif msg == "GET_USER_LIST":
                    self.get_active_users(conn)
                else:
                    self.handle_message(username, msg)
            except Exception as e:
                print(f"[ERROR] Client {username}: {e}")
                break

        conn.close()
        del self.active_users[username]

    def get_active_users(self, conn):
        usernames = ', '.join(self.active_users.keys())
        conn.send(f"Active users: {usernames}".encode(self.format))

    def handle_message(self, sender, message):
        try:
            target, msg = message.split(":", 1)
            
            if target == sender:
                self.active_users[sender].send("can't message urself!".encode(self.format))
                return
            
            if target in self.active_users:
                target_conn = self.active_users[target]
                target_conn.send(f"{sender}: {msg}".encode(self.format))
                print(f"[MESSAGE] {sender} -> {target}: {msg}")
                
            else:
                self.active_users[sender].send("User not found.".encode(self.format))
        except ValueError:
            self.active_users[sender].send("Invalid message format. Use 'username:message'.".encode(self.format))
            # important note: the username:message has the format of target:message! that usename is not the self.
            # to do: handle not to-self message.


if __name__ == "__main__":
    server = Server(host=socket.gethostbyname(socket.gethostname()), port=5050)
    server = Server(host="127.0.0.1", port=5050)
    server.start()
