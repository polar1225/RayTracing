package
{
	import flash.geom.Vector3D;

	/**
	 * 
	 * @author Polar
	 * @date:2015-11-30
	 */
	public class PerspectiveCamera
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		private var _eye	: Vector3D;
		private var _front	: Vector3D;
		private var _refUp	: Vector3D;
		private var _fov	: Number;
		
		private var _right		: Vector3D;
		private var _up			: Vector3D;
		private var _fovScale	: Number;
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function PerspectiveCamera(eye:Vector3D,front:Vector3D,up:Vector3D,fov:Number)
		{
			_eye = eye;
			_front = front;
			_refUp = up;
			_fov = fov;
		}
		
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		public function initialize():void{
			_right = _front.crossProduct(_refUp);
			_up = _right.crossProduct(_front);
			_fovScale = Math.tan(_fov * 0.5 * Math.PI / 180) * 2;
		}
		
		public function generateRay(x:Number,y:Number):Ray{
			var r:Vector3D = _right.clone();
			r.scaleBy((x - 0.5) * _fovScale);
			var u:Vector3D = _up.clone();
			u.scaleBy((y - 0.5) * _fovScale);
			var dir:Vector3D = _front.add(r).add(u);
			dir.normalize();
			return new Ray(_eye,dir);
		}
	}
}