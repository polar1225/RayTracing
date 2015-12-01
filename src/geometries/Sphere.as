package geometries
{
	import flash.geom.Vector3D;
	
	import materials.IMaterial;

	/**
	 * 
	 * @author Polar
	 * @date:2015-11-30
	 */
	public class Sphere extends Geometry
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		private var _center		: Vector3D;
		private var _radius		: Number;
		private var _sqrtRadius	: Number;
		private var _material	: IMaterial;
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function Sphere(center:Vector3D,radius:Number)
		{
			_center = center;
			_radius = radius;
			_sqrtRadius = radius * radius;
		}
		
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		public override function intersect(ray:Ray):IntersectResult{
			var v:Vector3D = ray.origin.subtract(_center);
			var a0:Number = v.lengthSquared - _sqrtRadius;
			var DdotV:Number = ray.direction.dotProduct(v);
			if(DdotV <= 0){
				var discr:Number = DdotV * DdotV - a0;
				if(discr >= 0){
					var result:IntersectResult = new IntersectResult;
					result.geometry = this;
					result.distance = - DdotV - Math.sqrt(discr);
					result.position = ray.getPoint(result.distance);
					result.normal = result.position.subtract(_center);
					result.normal.normalize();
					return result;
				}
			}
			return IntersectResult.noHit;
		}
	}
}