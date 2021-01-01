## vs 设置

1. 关掉幽灵/熔断漏洞缓解检查。

> Create a win32 console project and click project name to properties, Enable “Spectre Mitigation” under C/C++ Code Generation.

2. canary 栈帧实时检查
`/RTCs`
`/GZ`

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
## 触发蓝屏
```c++
#include <windows.h>

typedef NTSTATUS(NTAPI *TFNRtlAdjustPrivilege)(ULONG Privilege, BOOLEAN Enable, BOOLEAN CurrentThread, PBOOLEAN Enabled);

typedef NTSTATUS(NTAPI *TFNNtRaiseHardError)(NTSTATUS ErrorStatus, ULONG NumberOfParameters,
    ULONG UnicodeStringParameterMask, PULONG_PTR *Parameters, ULONG ValidResponseOption, PULONG Response);

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int cmdShow)
{
	HMODULE hNtdll = GetModuleHandle("ntdll.dll");

	if (hNtdll != 0)
	{
		NTSTATUS s1, s2;
		BOOLEAN b;
		ULONG r;

		TFNRtlAdjustPrivilege pfnRtlAdjustPrivilege = (TFNRtlAdjustPrivilege)GetProcAddress(hNtdll, "RtlAdjustPrivilege");
		s1 = pfnRtlAdjustPrivilege(19, true, false, &b);

		TFNNtRaiseHardError pfnNtRaiseHardError = (TFNNtRaiseHardError)GetProcAddress(hNtdll, "NtRaiseHardError");
		s2 = pfnNtRaiseHardError(0xDEADDEAD, 0, 0, 0, 6, &r);
	}
	return 0;
}
```