## basic

### init fps count
```js
var stats = new Stats();
stats.domElement.style.position = "absolute";
stats.domElement.style.left = "0px";
stats.domElement.style.top = "0px";
document.getElementById("Stats.output").appendChild(stats.domElement);
```

change stats format
```css
#stats #fps {
    background: transparent !important
}
            
#stats #fps #fpsText {
    color: #000000 !important
}
            
#stats #fps #fpsGraph {
    /*display: none;*/
}
```

### init basic elements;

```js
var scene = new THREE.Scene();

var camera = new THREE.PerspectiveCamera(45,window.innerWidth / window.innerHeight, 0.1, 1000);
camera.position.x = -30;
camera.position.y = 40;
camera.position.z = 50;
camera.lookAt(new THREE.Vector3(0, 0, 0));

var renderer = new THREE.WebGLRenderer();
renderer.setClearColor(0xB9D3EE);
renderer.setSize(window.innerWidth,window.innerHeight);

container.appendChild(renderer.domElement);
scene.add(camera);
```

### render
```js
function render(){
stats.update()//update fps count
requestAnimationFrame(render)
renderer.render(scene,camera);
}
```
### scene
物体、光源、控制器的添加必须使用secen.add(object)添加到场景中才能渲染出来。
一个3D项目中可同时存在多个scene，通过切换render的scene来切换显示场景。
```js
var scene = new THREE.Scene();
var mesh=scene.getObjectByName("sky");//获取场景中name=sky的物体；
```

## material
```js
   child.material.side=THREE.DoubleSide; //?
```
## load obj
You need OBJLOader.js

```js
function load() {
    var loader = new THREE.OBJLoader();
    loader.load("bunny_1k.obj",function (obj) {
        obj.name="rabbit";
        obj.traverse(function (child) {
            if (child instanceof THREE.Mesh){
                // child.material.side=THREE.DoubleSide;//??

                //set material on loading
                child.material = new THREE.MeshLambertMaterial({
                color: 0xffff00,
                side: THREE.DoubleSide
                });
                mesh=obj;
                mesh.scale.set(3,3,3);
                mesh.position.setY(-0.5);
                mesh.position.setX(0.5);
            }
        });
        scene.add(obj);
    });
}

```
set material with MTL
```js
var loader = new THREE.OBJMTLLoader();
loader.addEventListener('load', function(event) {
    var obj = event.content;
    mesh = obj;
    scene.add(obj);
});
loader.load('../lib/port.obj', '../lib/port.mtl');
```
### texture
load from pictor
```js
var map = THREE.ImageUtils.loadTexture("/lib/textures/disturb.jpg");
```

## light

### directional light
```js
var directionalLight = new THREE.DirectionalLight( 0xffeedd );
directionalLight.position.set( 0, 0, 1 );
scene.add( directionalLight );
```

### PointLight

```js
var pointlight = new THREE.PointLight(0xffffff, 1, 3000); 
pointlight.position.set(0, 0, 2000);//设置点光源位置
scene.add( pointlight );
```
### ambientLight

```js
var ambient = new THREE.AmbientLight( 0xcccccc );
scene.add( ambient );
```

## event

windowResize
```js
function onWindowResize() {
    camera.aspect=window.innerWidth/window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
    // controls.handleResize();
}
window.addEventListener("resize",onWindowResize,false);
```

## controls

- FlyControls:飞行控制，用键盘和鼠标控制相机的移动和转动
- OrbitControls::轨道控制器，模拟轨道中的卫星，绕某个对象旋转平移，用键盘和鼠标控制相机位置
- PointerLockControls:指针锁定，鼠标离开画布依然能被捕捉到鼠标交互，主要用于游戏
- TrackballControls：轨迹球控制器，通过键盘和鼠标控制前后左右平移和缩放场景
- TransformControls:变换物体控制器，可以通过鼠标对物体的进行拖放等操作

```js
var controls = new THREE.OrbitControls(camera,container);
//controls.maxPolarAngle=1.5;
//controls.minPolarAngle=1;
controls.enableDamping=true;
controls.enableKeys=false;
controls.enablePan=false;
controls.dampingFactor = 0.1;
controls.rotateSpeed=0.1;
//      controls.enabled = false;
//controls.minDistance=1000;
//controls.maxDistance=3000;
```