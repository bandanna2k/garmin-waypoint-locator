import Test.Utilities.Assertions;
import Bearing;
import Toybox.Position;
import Toybox.Lang;
import Toybox.Test;
import Toybox.Math;
import Toybox.StringUtil;

module Test { module TestBase64
{
    (:test) function testLargeEncoding(logger as Logger) as Boolean 
    { 
        var encoded = StringUtil.encodeBase64(LARGE_STRING);
        var decoded = StringUtil.convertEncodedString(
            encoded, 
            {
                :fromRepresentation => StringUtil.REPRESENTATION_STRING_BASE64,
                :toRepresentation => StringUtil.REPRESENTATION_STRING_PLAIN_TEXT,
                :encoding => StringUtil.CHAR_ENCODING_UTF8
            });

        Logging.debug("Size of LARGE_STRING:" + LARGE_STRING.length());
        Logging.debug("Size of encoded     :" + encoded.length());
        Logging.debug("Encoded     :" + encoded);
        Logging.debug("Size of decoded:" + decoded.length());
        return true;
    }

    (:test) function testJustEncoding(logger as Logger) as Boolean 
    { 
        var encoded = StringUtil.convertEncodedString(
            LARGE_STRING, 
            {
                :fromRepresentation => StringUtil.REPRESENTATION_STRING_PLAIN_TEXT,
                :toRepresentation => StringUtil.REPRESENTATION_STRING_BASE64,
                :encoding => StringUtil.CHAR_ENCODING_UTF8
            });
        var decoded = StringUtil.convertEncodedString(
            encoded, 
            {
                :fromRepresentation => StringUtil.REPRESENTATION_STRING_BASE64,
                :toRepresentation => StringUtil.REPRESENTATION_STRING_PLAIN_TEXT,
                :encoding => StringUtil.CHAR_ENCODING_UTF8
            });

        Logging.debug("Size of encoded     :" + encoded.length());
        Logging.debug("Encoded     :" + encoded);
        Logging.debug("Size of decoded:" + decoded.length());
        return true;
    }



    const LARGE_STRING = ""+
"{" +
"	'name': 'AKL, Parnell Baths to Namata Rd'," +
"	'waypoints': [" +
"		{" +
"			'title': 'Parnell Baths'," +
"			'latitude': -36.84876486747412," +
"			'longitude': 174.79255181951655" +
"		}," +
"		{" +
"			'title': 'Broadway (turn left onto)'," +
"			'latitude': -36.85949591737477," +
"			'longitude': 174.78285295168604" +
"		}," +
"		{" +
"			'title': 'Cowie St (left onto)'," +
"			'latitude': -36.86332439138662," +
"			'longitude': 174.78098613421116 " +
"		}," +
"		{" +
"			'title': 'Laxon Terrace Walkway'," +
"			'latitude': -36.86656900157937," +
"			'longitude': 174.78073937099208" +
"		}," +
"		{" +
"			'title': 'James Cook Cres'," +
"			'latitude': -36.869950803198684," +
"			'longitude': 174.78107196492533" +
"		}," +
"		{" +
"			'title': 'Belmont Terrace (right onto)'," +
"			'latitude': -36.87115671404519," +
"			'longitude': 174.7819356362308 " +
"		}," +
"		{" +
"			'title': 'Remuera Rd (left onto)'," +
"			'latitude': -36.872371188624044," +
"			'longitude': 174.78051406544674" +
"		}," +
"		{" +
"			'title': 'Dilworth Ave (right onto)'," +
"			'latitude': -36.87509617610754," +
"			'longitude': 174.7846071164198" +
"		}," +
"		{" +
"			'title': 'Great South Rd (left onto)'," +
"			'latitude': -36.87881659262674," +
"			'longitude': 174.78155476254915 " +
"		}," +
"		{" +
"			'title': 'Aratonga Ave (right onto)'," +
"			'latitude': -36.88659583984536," +
"			'longitude': 174.78863042993578 " +
"		}," +
"		{" +
"			'title': 'Renown Ave (right onto)'," +
"			'latitude': -36.89070182999788," +
"			'longitude': 174.78844803972785" +
"		}" +
"	]" +
"}    " +
"    ';";
}}