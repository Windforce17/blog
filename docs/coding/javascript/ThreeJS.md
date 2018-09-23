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

## load obj
You need OBJLOader.js

```js
function load() {
    var loader = new THREE.OBJLoader();
    loader.load("bunny_1k.obj",function (obj) {
        obj.name="rabbit";
        obj.traverse(function (child) {
            if (child instanceof THREE.Mesh){
                // child.material.side=THREE.DoubleSide;
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

## light

### directional light
```js
var directionalLight = new THREE.DirectionalLight( 0xffeedd );
directionalLight.position.set( 0, 0, 1 );
scene.add( directionalLight );
```