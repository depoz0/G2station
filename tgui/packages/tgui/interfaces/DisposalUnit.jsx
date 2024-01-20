import { useBackend } from '../backend';
import { Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const DisposalUnit = (props) => {
  const { act, data } = useBackend();
  let stateColor;
  let stateText;
  if (data.full_pressure) {
    stateColor = 'good';
    stateText = 'Готово';
  } else if (data.panel_open) {
    stateColor = 'bad';
    stateText = 'Питание отключено';
  } else if (data.pressure_charging) {
    stateColor = 'average';
    stateText = 'Нагнетание давления';
  } else {
    stateColor = 'bad';
    stateText = 'Выкл';
  }
  return (
    <Window width={300} height={180}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Статус" color={stateColor}>
              {stateText}
            </LabeledList.Item>
            <LabeledList.Item label="Давление">
              <ProgressBar value={data.per} color="good" />
            </LabeledList.Item>
            <LabeledList.Item label="Рукоять">
              <Button
                icon={data.flush ? 'toggle-on' : 'toggle-off'}
                disabled={data.isai || data.panel_open}
                content={data.flush ? 'Отключить' : 'Включить'}
                onClick={() => act(data.flush ? 'handle-0' : 'handle-1')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Извлечь">
              <Button
                icon="sign-out-alt"
                disabled={data.isai}
                content="Извлечь содержимое"
                onClick={() => act('eject')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Питание">
              <Button
                icon="power-off"
                disabled={data.panel_open}
                selected={data.pressure_charging}
                onClick={() =>
                  act(data.pressure_charging ? 'pump-0' : 'pump-1')
                }
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
