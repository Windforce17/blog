# Qt图片处理

## 显示图片

```cpp
    QString filename;
    filename=QFileDialog::getOpenFileName(this,tr("选择图像"),"",tr("Images (*.png *.bmp *.jpg *.tif *.GIF )"));
    if(filename.isEmpty())
    {
         return;
    }
    else
    {
        QImage* img=new QImage;

        if(! ( img->load(filename) ) ) //加载图像
        {
            QMessageBox::information(this,
                                     tr("打开图像失败"),
                                     tr("打开图像失败!"));
            delete img;
            return;
        }
        ui->label->setPixmap(QPixmap::fromImage(*img));
    }
```

## 图片缩放

图像缩放采用scaled函数。函数原型

```cpp
QImage QImage::scaled ( const QSize & size,Qt::AspectRatioMode aspectRatioMode = Qt::IgnoreAspectRatio, Qt::TransformationModetransformMode = Qt::FastTransformation ) const
//使用方法如下，还是利用上面的img：

QImage* imgScaled = new QImage；
*imgScaled=img->scaled(width,
                       height,
                       Qt::KeepAspectRatio);
ui->label->setPixmap(QPixmap::fromImage(*imgScaled));
```

## 图片旋转

```cpp
QImage* imgRatate = new QImage;
QMatrix matrix;
matrix.rotate(270);
*imgRotate = img->transformed(matrix);
ui->label->setPixmap(QPixmap::fromImage(*imgRotate));
```