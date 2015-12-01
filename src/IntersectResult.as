package
{
	import flash.geom.Vector3D;
	
	import geometries.Geometry;

	/**
	 * 
	 * @author Polar
	 * @date:2015-11-30
	 */
	public class IntersectResult
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		public static var noHit:IntersectResult = new IntersectResult();
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		public var geometry	: Geometry;
		public var distance	: Number;
		public var position	: Vector3D;
		public var normal	: Vector3D;
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function IntersectResult()
		{
			geometry = null;
			distance = 0;
			position = new Vector3D;
			normal = new Vector3D;
		}
		
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
	}
}