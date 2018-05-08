var monthNames = ["01月", "02月", "03月", "04月", "05月", "06月",
    "07月", "08月", "09月", "10月", "11月", "12月"
];
var dayNames = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]

var newDate = new Date();
newDate.setDate(newDate.getDate());
$('#Date').html( newDate.getFullYear()+'年 ' + monthNames[newDate.getMonth()] + ' ' + newDate.getDate() + '号 '+dayNames[newDate.getDay()] );
