package
{
	/**
	 * 
	 * @author Polar
	 * @date:2015-11-30
	 */
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import geometries.Geometry;
	import geometries.IIntersectGeom;
	import geometries.Plane;
	import geometries.Sphere;
	
	import materials.CheckerMaterial;
	import materials.Color;
	import materials.PhongMaterial;

	[SWF(frameRate="60",width="800",height="600")]
	public class RayTracing extends Sprite
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		private var _bitmapData:BitmapData;
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function RayTracing()
		{
			if(stage)
				onAddedToStage(null);
			else
				addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			_bitmapData = new BitmapData(512,512,true,0xff000000);
			var bitmap:Bitmap = new Bitmap(_bitmapData);
			stage.addChild(bitmap);
			
//			setBitmap();
			setupScene();
		}
		
		private function setBitmap():void{
			var width:Number = _bitmapData.width;
			var height:Number = _bitmapData.height;
			for(var i:int = 0; i < width; ++i){
				for(var j:int = 0; j < height; ++j){
					var size:int = 32;
					if( (Math.floor(i / size)  %2 + Math.floor(j / size))  %2 == 0){
						_bitmapData.setPixel(i,j,0);
					}else{
						_bitmapData.setPixel(i,j,0xffffffff);
					}
				}
			}
		}
		
		private function setupScene():void{
//			var geom:Sphere = new Sphere(new Vector3D(0, 10, -10), 10);
//			var camera:PerspectiveCamera = new PerspectiveCamera(new Vector3D(0, 10, 10), 
//					new Vector3D(0, 0, -1), new Vector3D(0, 1, 0), 90);
//			renderDepth(_bitmapData,geom,camera,20);
//			renderNormal(_bitmapData,geom,camera);
			
			var camera2:PerspectiveCamera = new PerspectiveCamera(new Vector3D(0, 5, 15), 
				new Vector3D(0, 0, -1), new Vector3D(0, 1, 0), 90)
			var plane:Plane = new Plane(new Vector3D(0, 1, 0), 0);
			plane.material = new CheckerMaterial(0.3,0.4);
			var sphere1:Sphere = new Sphere(new Vector3D(-10, 10, -10), 10);
			var sphere2:Sphere = new Sphere(new Vector3D(10, 10, -10), 10);
			sphere1.material = new PhongMaterial(Color.red, Color.white, 16,0.2);
			sphere2.material = new PhongMaterial(Color.blue, Color.white, 16,0.2);
			
			var mesh:Union = new Union(plane,sphere1,sphere2);
//			rayTrace(_bitmapData,mesh,camera2);
			rayTraceReflection(_bitmapData,mesh,camera2,3);
		}
		
		private function renderDepth(bitmap:BitmapData, geom:Geometry, camera:PerspectiveCamera, maxDepth:Number):void {
			camera.initialize();
			var h:Number = bitmap.height;
			var w:Number = bitmap.width;
			var i:Number = 0;
			bitmap.lock();
			for (var y:int = 0; y < h; y++) {
				var sy:Number = 1 - y / h;
				for (var x:int = 0; x < w; x++) {
					var sx:Number = x / w;            
					var ray:Ray = camera.generateRay(sx, sy);
					var result:IntersectResult = geom.intersect(ray);
					if (result.geometry) {
						var depth:Number = 255 - Math.min((result.distance / maxDepth) * 255, 255);
						bitmap.setPixel(x,y, getColorHex(depth,depth,depth));
					}
				}
			}
			bitmap.unlock();
		}
		
		private function renderNormal(bitmap:BitmapData, geom:Geometry, camera:PerspectiveCamera):void {
			camera.initialize();
			var h:Number = bitmap.height;
			var w:Number = bitmap.width;
			var i:Number = 0;
			bitmap.lock();
			for (var y:int = 0; y < h; y++) {
				var sy:Number = 1 - y / h;
				for (var x:int = 0; x < w; x++) {
					var sx:Number = x / w;            
					var ray:Ray = camera.generateRay(sx, sy);
					var result:IntersectResult = geom.intersect(ray);
					if (result.geometry) {
						bitmap.setPixel(x,y, getColorHex((result.normal.x + 1) * 128,(result.normal.y + 1) * 128,(result.normal.z + 1) * 128));
					}
				}
			}
			bitmap.unlock();
		}
		
		private function rayTrace(bitmap:BitmapData, geom:IIntersectGeom, camera:PerspectiveCamera):void {
			camera.initialize();
			var h:Number = bitmap.height;
			var w:Number = bitmap.width;
			var i:Number = 0;
			bitmap.lock();
			for (var y:int = 0; y < h; y++) {
				var sy:Number = 1 - y / h;
				for (var x:int = 0; x < w; x++) {
					var sx:Number = x / w;            
					var ray:Ray = camera.generateRay(sx, sy);
					var result:IntersectResult = geom.intersect(ray);
					if (result.geometry) {
						bitmap.setPixel(x,y,result.geometry.material.sample(ray,result.position,result.normal).hex);
					}
				}
			}
			bitmap.unlock();
		}
		
		private function rayTraceRecursive(scene:IIntersectGeom,ray:Ray,maxReflect:int):Color{
			var result:IntersectResult = scene.intersect(ray);
			if (result.geometry) {
				var reflectiveness:Number = result.geometry.material.reflectiveness;
				var color:Color = result.geometry.material.sample(ray, result.position, result.normal);
				color = color.multiply(1 - reflectiveness);
				
				if (reflectiveness > 0 && maxReflect > 0) {
					var r:Vector3D = result.normal.clone();
					r.scaleBy(-2 * result.normal.dotProduct(ray.direction));
					r = r.add(ray.direction);
					ray = new Ray(result.position, r);
					var reflectedColor:Color = rayTraceRecursive(scene, ray, maxReflect - 1);
					color = color.add(reflectedColor.multiply(reflectiveness));
				}
				return color;
			}
			else
				return Color.black;
		}
		
		
		private function rayTraceReflection(bitmap:BitmapData, geom:IIntersectGeom, camera:PerspectiveCamera,maxReflect:int):void {
			camera.initialize();
			var h:Number = bitmap.height;
			var w:Number = bitmap.width;
			var i:Number = 0;
			bitmap.lock();
			for (var y:int = 0; y < h; y++) {
				var sy:Number = 1 - y / h;
				for (var x:int = 0; x < w; x++) {
					var sx:Number = x / w;            
					var ray:Ray = camera.generateRay(sx, sy);
					bitmap.setPixel(x,y,rayTraceRecursive(geom, ray, maxReflect).hex);
				}
			}
			bitmap.unlock();
		}
		
		private function getColorHex(r:int,g:int,b:int):uint{
			return r << 16 | g << 8 | b;
		}
	}
}