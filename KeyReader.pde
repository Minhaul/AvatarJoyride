
import java.awt.event.KeyEvent;

class KeyReader
{
  private boolean[] keys;
  private HashMap<String, Integer> keyMap;
    
  KeyReader()
  {
    keys = new boolean[256];
    keyMap = new HashMap<String, Integer>();
    for (int i = 0; i < keys.length; i++)
      keyMap.put(KeyEvent.getKeyText(i).toLowerCase(), i);
  }
  
  boolean check(String k)
  {
    Integer code = keyMap.get(k.toLowerCase());
    return code != null && keys[code];
  }
  
  void onKeyPressed()
  {
    keys[keyCode] = true;
  }
  
  void onKeyReleased()
  {
    keys[keyCode] = false;
  }
}
