from litellm.integrations.custom_logger import CustomLogger  
from litellm.proxy.proxy_server import UserAPIKeyAuth, DualCache  
from typing import Any, Literal  
  
class MessageTruncationHandler(CustomLogger):  
    def __init__(self, max_messages: int = 10):  
        self.max_messages = max_messages  

    async def async_pre_call_hook(self, user_api_key_dict: UserAPIKeyAuth, cache: DualCache, data: dict, call_type: Literal[
            "completion",
            "text_completion",
            "embeddings",
            "image_generation",
            "moderation",
            "audio_transcription",
        ])  -> dict: 
        # メッセージリストを取得  
        messages = data.get("messages", [])  
          
        # メッセージ数が制限を超えている場合、直近のmax_messages件に絞り込む  
        if len(messages) > self.max_messages:  
            # systemメッセージは保持し、直近のmax_messages-1件を追加  
            system_messages = [msg for msg in messages if msg.get("role") == "system"]  
            other_messages = [msg for msg in messages if msg.get("role") != "system"]  
              
            # 直近のメッセージを取得  
            recent_messages = other_messages[-(self.max_messages - len(system_messages)):]  
              
            # systemメッセージと直近メッセージを結合  
            data["messages"] = system_messages + recent_messages  
              
            print(f"Truncated messages from {len(messages)} to {len(data['messages'])}")  
          
        return data  
  
# インスタンスを作成  
message_truncation_handler = MessageTruncationHandler(max_messages=20)
