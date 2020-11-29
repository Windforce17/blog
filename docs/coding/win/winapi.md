## 数据类型

1. HANDLE 句柄
2. HINSTANCE 实例
3. HICON 图标
4. WNDCLASSEXW wcex 窗口

## 取消菜单

wcex.lpszMenuName = NULL;//MAKEINTRESOURCEW(IDC_WIN32API);

## 消息

WM_LBUTTONDOWN 鼠标左键按下

1. 魔兽防暂离：

```c
hWOW = FindWindow(NULL, "魔兽世界");
PostMessage(hWOW, WM_KEYDOWN, 0x20, NULL); //0x20空格键
PostMessage(hWOW, WM_CHAR, 0x20, NULL);
PostMessage(hWOW, WM_KEYUP, 0x20, NULL);
```
