package geometries
{
	import materials.IMaterial;

	/**
	 * 
	 * @author Polar
	 * @date:2015-12-1
	 */
	public class Geometry implements IIntersectGeom
	{
		private var _material : IMaterial;

		public function get material():IMaterial
		{
			return _material;
		}

		public function set material(value:IMaterial):void
		{
			_material = value;
		}

		
		public function intersect(ray:Ray):IntersectResult{
			throw new Error("Abstract Class!");
		}
	}
}