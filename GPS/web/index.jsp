<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>EXIF</title>
    </head>
    <body>
        <!--<img src="IMG20180530182205.jpg" id="the-img" style="max-width: 200px;"><br>-->
        <img id="blah" src="#" alt="your image" style="max-width: 200px;"/><br>
        <input type='file' id="fImage" />
        <p id="pic-info"></p>
        <p id="map-link"></p>
        <p id="map-link2"></p>
        <script type="text/javascript" src="exif.js"></script>
        <script>
//            document.getElementById("the-img").onclick = function () {
//
//                EXIF.getData(this, function () {
//
//                    myData = this;
//                    console.log(myData);
//                    console.log(myData.exifdata);
//
//                    document.getElementById('pic-info').innerHTML = 'This photo was taken on ' + myData.exifdata.DateTime + ' with a ' + myData.exifdata.Make + ' ' + myData.exifdata.Model;
//
//                    // Calculate latitude decimal
//                    var latDegree = myData.exifdata.GPSLatitude[0].numerator;
//                    var latMinute = myData.exifdata.GPSLatitude[1].numerator;
//                    var latSecond = myData.exifdata.GPSLatitude[2].numerator;
//                    var latDirection = myData.exifdata.GPSLatitudeRef;
//
//                    var latFinal = ConvertDMSToDD(latDegree, latMinute, latSecond, latDirection);
//                    console.log(latFinal);
//
//                    // Calculate longitude decimal
//                    var lonDegree = myData.exifdata.GPSLongitude[0].numerator;
//                    var lonMinute = myData.exifdata.GPSLongitude[1].numerator;
//                    var lonSecond = myData.exifdata.GPSLongitude[2].numerator;
//                    var lonDirection = myData.exifdata.GPSLongitudeRef;
//
//                    var lonFinal = ConvertDMSToDD(lonDegree, lonMinute, lonSecond, lonDirection);
//                    console.log(lonFinal);
//
//                    document.getElementById('map-link').innerHTML = '<a href="http://www.google.com/maps/place/' + latFinal + ',' + lonFinal + '" target="_blank">Google Maps</a>';
//                    document.getElementById('map-link2').innerHTML = '<a href="http://www.google.com/maps/place/' + latDirection + ',' + lonDirection + '" target="_blank">Google Maps</a>';
//
//                });
//            }

            document.getElementById("fImage").onchange = function (e) {
                readURL(this);
                var file = e.target.files[0];
                if (file && file.name) {
                    EXIF.getData(file, function () {
                        var exifData = EXIF.pretty(this);
                        if (exifData) {
                            console.log(exifData);
                        } else {
                            console.log("No EXIF data found in image '" + file.name + "'.");
                        }
                        myData = file;
                        console.log(myData);
                        console.log(myData.exifdata);
                        document.getElementById('pic-info').innerHTML = 'This photo was taken on ' + myData.exifdata.DateTime + ' with a ' + myData.exifdata.Make + ' ' + myData.exifdata.Model;

                        // Calculate latitude decimal
                        var latDegree = myData.exifdata.GPSLatitude[0].numerator;
                        var latMinute = myData.exifdata.GPSLatitude[1].numerator;
                        var latSecond = myData.exifdata.GPSLatitude[2].valueOf();
                        var latDirection = myData.exifdata.GPSLatitudeRef;

                        var latFinal = ConvertDMSToDD(latDegree, latMinute, latSecond, latDirection);
                        console.log(latFinal);

                        // Calculate longitude decimal
                        var lonDegree = myData.exifdata.GPSLongitude[0].numerator;
                        var lonMinute = myData.exifdata.GPSLongitude[1].numerator;
                        var lonSecond = myData.exifdata.GPSLongitude[2].valueOf();
                        var lonDirection = myData.exifdata.GPSLongitudeRef;

                        var lonFinal = ConvertDMSToDD(lonDegree, lonMinute, lonSecond, lonDirection);
                        console.log(lonFinal);
                        console
                        document.getElementById('map-link').innerHTML = '<a href="http://www.google.com/maps/place/' + latFinal + ',' + lonFinal + '" target="_blank">Google Maps</a>';
                        document.getElementById('map-link2').innerHTML = 'Distance= ' + distance(10.852904, 106.6252806, latFinal, lonFinal, 'Me') + ' m';
                    });
                }
            }
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
//                        $('#blah').attr('src', e.target.result);
                        document.getElementById("blah").setAttribute("src", e.target.result);
                    }

                    reader.readAsDataURL(input.files[0]);
                }
            }
            function ConvertDMSToDD(degrees, minutes, seconds, direction) {

                var dd = degrees + (minutes / 60) + (seconds / 3600);

                if (direction == "S" || direction == "W") {
                    dd = dd * -1;
                }

                return dd;
            }

            function distance(lat1, lon1, lat2, lon2, unit) {
                if ((lat1 == lat2) && (lon1 == lon2)) {
                    return 0;
                } else {
                    var radlat1 = Math.PI * lat1 / 180;
                    var radlat2 = Math.PI * lat2 / 180;
                    var theta = lon1 - lon2;
                    var radtheta = Math.PI * theta / 180;
                    var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
                    if (dist > 1) {
                        dist = 1;
                    }
                    dist = Math.acos(dist);
                    dist = dist * 180 / Math.PI;
                    dist = dist * 60 * 1.1515;
                    if (unit == "K") {
                        dist = dist * 1.609344;
                    }
                    if (unit == "N") {
                        dist = dist * 0.8684;
                    }
                    if (unit == "Me") {
                        dist = dist * 1609.344;
                    }
                    return dist;
                }
            }
        </script>
    </body>
</html>
