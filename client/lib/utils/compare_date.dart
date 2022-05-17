bool compareDate(DateTime time) {
  final dateNow = DateTime.now();
  if (time.year > dateNow.year) {
    return true;
  } else if (time.year < dateNow.year) {
    return false;
  }

  if (time.month > dateNow.month) {
    return true;
  } else if (time.month < dateNow.month) {
    return false;
  }

  if (time.day > dateNow.day) {
    return true;
  } else if (time.day < dateNow.day) {
    return false;
  }

  if (time.hour > dateNow.hour) {
    return true;
  } else if (time.hour < dateNow.hour) {
    return false;
  }

  if (time.minute > dateNow.minute) {
    return true;
  } else if (time.minute < dateNow.minute || time.minute == dateNow.minute) {
    return false;
  }

  return false;
}
