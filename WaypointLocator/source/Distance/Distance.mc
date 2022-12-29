import Toybox.Lang;

class Distance 
{
    var _valueInMm;

    static function fromMiles(miles as Lang.Number)
    {
        return new Distance(miles * 1609344);
    }

    static function fromMetres(metres as Lang.Numeric)
    {
        return new Distance(metres * 1000);
    }

    function initialize(mm as Lang.Number)
    {
        _valueInMm = mm;
    }

    function kilometres() as Lang.Numeric
    {
        return metres() / 1000;
    }

    function metres() as Lang.Numeric
    {
        return _valueInMm / 1000;
    }

    function miles() as Lang.Numeric
    {
        return 0;
    }
}