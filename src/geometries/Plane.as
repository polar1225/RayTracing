package geometries
{
	/**
	 * 
	 * @author Polar
	 * @date:2015-12-1
	 */
	import flash.geom.Vector3D;
	
	import materials.IMaterial;
	
	public class Plane extends Geometry
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		private var _normal		: Vector3D;
		private var _d			: Number;
		private var _position	: Vector3D;
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function Plane(normal:Vector3D,d:Number)
		{
			_normal = normal;
			_d = d;
			_position = normal.clone();
			_position.scaleBy(d);
		}
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		public override function intersect(ray:Ray):IntersectResult
		{
			var a:Number = ray.direction.dotProduct(_normal);
			if (a >= 0)
				return IntersectResult.noHit;
			
			var b:Number = _normal.dotProduct(ray.origin.subtract(_position));
			var result:IntersectResult = new IntersectResult();
			result.geometry = this;
			result.distance = -b / a;
			result.position = ray.getPoint(result.distance);
			result.normal = _normal;
			return result;
		}
	}
}