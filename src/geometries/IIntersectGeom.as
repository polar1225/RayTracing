package geometries
{
	/**
	 * 
	 * @author Polar
	 * @date:2015-12-1
	 */
	public interface IIntersectGeom
	{
		function intersect(ray:Ray):IntersectResult;
	}
}