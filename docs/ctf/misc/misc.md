## 杂项
stegosolve 图片隐写
binwalk 识别文件合成
foremost 分离合并的多个文件
stegdetect 检查jpeg淫邪，使用DCT。
exiftool 读取jpeg中的exif信息
pngcheck 分析png中的压缩信息
python-PIL 处理图片库
## NTFS 

### NTFS 文件恢复
https://blog.csdn.net/qq_18218335/article/details/57415615
### ADS流
这是一种``隐藏文件``的方法

## 创建数据流

    c:\test>echo Hello, freebuf! > test.txt:ThisIsAnADS

## 列出数据流

c:\test>dir /r test.txt

## 查看ADS内容

PS C:\test> Get-Content test.txt -stream ThisIsAnADS

# png

## png图片格式http://www.cnblogs.com/fengyv/archive/2006/04/30/2423964.html

## 查看IDAT数据块
pngcheck.exe -v xxx.png 正常一个快是65524

#zlib

78 9C是zlib压缩标志
zlib扩展阅读http://zlib.net/

# GIF
开头GIF8(7/9)a
扩展阅读
http://dev.gameres.com/Program/Visual/Other/GIFDoc.htm
可以用Stegsolve播放帧
# PIL库的使用
import Image
MAX = 25
pic = Image.new("RGB",(MAX, MAX))
str = "1111111000100001101111111100000101110010110100000110111010100000000010111011011101001000000001011101101110101110110100101110110000010101011011010000011111111010101010101111111000000001011101110000000011010011000001010011101101111010101001000011100000000000101000000001001001101000100111001111011100111100001110111110001100101000110011100001010100011010001111010110000010100010110000011011101100100001110011100100001011111110100000000110101001000111101111111011100001101011011100000100001100110001111010111010001101001111100001011101011000111010011100101110100100111011011000110000010110001101000110001111111011010110111011011"
i=0
for y in range (0,MAX):
    for x in range (0,MAX):
        if(str[i] == '1'):
            pic.putpixel([x,y],(0, 0, 0))
        else:
            pic.putpixel([x,y],(255,255,255))
        i = i+1
pic.show()
pic.save("flag.png")

## base64转图片

<img src="data:image/jpg;base64,ZmxhZ3t4Y3Rmezg4MzEyN2QyNzI2MjZjOWFmN2Q3M2Q5M2JlMDBkZTQ3fX0=">