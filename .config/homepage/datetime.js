function formatDateTime(date) {
  const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  const dayOfWeek = daysOfWeek[date.getDay()];
  const day = date.getDate();
  const month = months[date.getMonth()];
  const hours = date.getHours();
  const minutes = date.getMinutes();

  const formattedDateTime = `${dayOfWeek}, ${day} ${month} @ ${hours}:${minutes < 10 ? '0' : ''}${minutes}`;

  return formattedDateTime;
}

// Function to update the time every second
function updateDateTime() {
  // Get the current date and time
  const currentDate = new Date();

  // Format the date and time
  const formattedDateTime = formatDateTime(currentDate);

  // Insert into the HTML element with id "currentDateTime"
  document.getElementById('dateTime').innerText = formattedDateTime;
}

updateDateTime();
setInterval(updateDateTime, 1000);
