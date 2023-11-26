export const PHYSICALSTATUS2ICON = {
  Active: 'person-running',
  Debilitated: 'crutch',
  Unconscious: 'moon-o',
  Deceased: 'skull',
};

export const PHYSICALSTATUS2COLOR = {
  Active: 'green',
  Debilitated: 'purple',
  Unconscious: 'orange',
  Deceased: 'red',
} as const;

export const PHYSICALSTATUS2DESC = {
  Active: 'Активный. Человек находится в сознании и здоров.',
  Debilitated: 'Слабость. Личность находится в сознании, но нездорова.',
  Unconscious:
    'В бессознательном состоянии. Человеку может потребоваться медицинская помощь.',
  Deceased: 'Умерший. Человек умер и начал разлагаться.',
} as const;

export const MENTALSTATUS2ICON = {
  Stable: 'face-smile-o',
  Watch: 'eye-o',
  Unstable: 'scale-unbalanced-flip',
  Insane: 'head-side-virus',
};

export const MENTALSTATUS2COLOR = {
  Stable: 'green',
  Watch: 'purple',
  Unstable: 'orange',
  Insane: 'red',
} as const;

export const MENTALSTATUS2DESC = {
  Stable: 'Стабилен. Личность вменяема и не имеет психологических расстройств.',
  Watch:
    'Наблюдение. У человека наблюдаются симптомы психического заболевания. Внимательно следите за ними.',
  Unstable:
    'Нестабильность. Индивид страдает одним или несколькими психическими заболеваниями.',
  Insane:
    'Невменяемый. Лицо демонстрирует тяжелое, ненормальное психическое поведение.',
} as const;
