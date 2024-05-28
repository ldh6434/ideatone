let currentMonth = 5;

function prevMonth() {
    if (currentMonth > 1) {
        currentMonth--;
        updateMonthLabel();
    }
}

function nextMonth() {
    if (currentMonth < 12) {
        currentMonth++;
        updateMonthLabel();
    }
}

function updateMonthLabel() {
    document.getElementById('month-label').textContent = `${currentMonth}월`;
}
