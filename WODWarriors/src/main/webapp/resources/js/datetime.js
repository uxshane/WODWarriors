$(document).ready(function(){
            $("#location").click(function() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        $("#location").val(data.address);
                    }
                }).open();
            }); 
        });