package
{
	import geometries.IIntersectGeom;

	/**
	 * 
	 * @author Polar
	 * @date:2015-12-1
	 */
	public class Union implements IIntersectGeom
	{
		// ======================================================================
		//	Constants
		// ----------------------------------------------------------------------	
		
		// ======================================================================
		//	Properties
		// ----------------------------------------------------------------------
		public var geoms:Vector.<IIntersectGeom> = new Vector.<IIntersectGeom>;
		
		// ======================================================================
		//	Constructor
		// ----------------------------------------------------------------------
		public function Union(...args)
		{
			for each(var param:* in args){
				if(param is IIntersectGeom){
					geoms.push(param);
				}
			}
		}
		
		// ======================================================================
		//	Getters/Setters
		// ----------------------------------------------------------------------
		
		// ======================================================================
		//	Methods
		// ----------------------------------------------------------------------
		public function intersect(ray:Ray):IntersectResult
		{
			var minDistance:Number = Number.MAX_VALUE;
			var minResult:IntersectResult = IntersectResult.noHit;
			for (var i:int = 0; i < geoms.length;++i) {
				var result:IntersectResult = geoms[i].intersect(ray);
				if (result.geometry && result.distance < minDistance) {
					minDistance = result.distance;
					minResult = result;
				}
			}
			return minResult;
		}
		
	}
}