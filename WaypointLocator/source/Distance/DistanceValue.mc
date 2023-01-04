import Toybox.Lang;

module Distance 
{
    class DistanceValue
    {
        var _valueInMm;

        static function fromMiles(miles as Number)
        {
            return new DistanceValue(miles * 1609344);
        }

        static function fromMetres(metres as Numeric)
        {
            return new DistanceValue(metres * 1000);
        }

        function initialize(mm as Number)
        {
            _valueInMm = mm;
        }

        function kilometres() as Numeric
        {
            return metres() / 1000d;
        }

        function metres() as Numeric
        {
            return _valueInMm / 1000d;
        }

        function miles() as Numeric
        {
            return _valueInMm / 1609344d;
        }
    }
}