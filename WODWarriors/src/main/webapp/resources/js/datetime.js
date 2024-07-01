$(document).ready(function(){
            $("#date").datetimepicker({
                timepicker: false,
                format: 'Y-m-d',
                theme: 'light',
                onShow: function(ct) {
                    this.setOptions({
                        minDate: 0
                    });
                }
            });

            $("#time").datetimepicker({
                datepicker: false,
                format: 'H:i',
                step: 30,
                theme: 'light'
            });

            $("#location").click(function() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        $("#location").val(data.address);
                    }
                }).open();
            }); 
        });