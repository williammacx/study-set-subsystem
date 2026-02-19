export function getPartOfDay(date = new Date()) {
  const hours = date.getHours();

  if (hours >= 5 && hours < 12) {
    return 'morning';
  }else if(hours >= 12 && hours < 17) {
    return 'afternoon';
  }
  return 'evening';
}
