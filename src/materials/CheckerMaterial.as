package materials
{
	/**
	 * 
	 * @author Polar
	 * @date:2015-12-1
	 */
	import flash.geom.Vector3D;
	
	public class CheckerMaterial implements IMaterial
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		private var _scale:Number;
		private var _reflectiveness:Number;
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function CheckerMaterial(scale:Number,reflectiveness:Number)
		{
			_scale = scale;
			_reflectiveness = reflectiveness;
		}
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		
		public function sample(ray:Ray, position:Vector3D, normal:Vector3D):Color
		{
			return Math.abs((Math.floor(position.x * _scale) + Math.floor(position.z * _scale)) % 2) < 1 ? Color.black : Color.white;
		}
		
		public function get reflectiveness():Number
		{
			return _reflectiveness;
		}
		
	}
}