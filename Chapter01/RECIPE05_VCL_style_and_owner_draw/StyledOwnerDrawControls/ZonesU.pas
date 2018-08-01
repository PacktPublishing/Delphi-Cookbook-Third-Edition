unit ZonesU;

interface

uses LampInfoU;

const
  Zones: array [1 .. LAMPS_FOR_EACH_ROW * 4] of string = (
    'Corr. 1° floor', 'Room 101', 'Room 102', 'Room 103', 'Room 104',
    'Corr. 2° floor', 'Room 201', 'Room 202', 'Room 203', 'Room 204',
    'Corr. 3° floor', 'Room 301', 'Room 302', 'Room 303', 'Room 304',
    'Corr. 4° floor', 'Room 401', 'Room 402', 'Room 403', 'Room 404');

implementation

end.
