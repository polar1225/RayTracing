package
{
	import flash.geom.Vector3D;

	/**
	 * 
	 * @author Polar
	 * @date:2015-11-30
	 */
	public class Ray
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		private var _origin		: Vector3D;
		private var _direction	: Vector3D;

		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function Ray(origin:Vector3D,direction:Vector3D)
		{
			_origin = origin;
			_direction = direction;
		}
		
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		public function get origin():Vector3D
		{
			return _origin;
		}
		
		public function get direction():Vector3D
		{
			return _direction;
		}
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		public function getPoint(t:Number):Vector3D{
			var dir:Vector3D = _direction.clone();
			dir.normalize();
			dir.scaleBy(t);
			return _origin.add(dir);
		}
	}
}