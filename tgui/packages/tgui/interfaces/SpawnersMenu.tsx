import { capitalizeAll } from 'common/string';
import { useBackend } from 'tgui/backend';
import { Button, LabeledList, Section, Stack } from 'tgui/components';
import { Window } from 'tgui/layouts';

type SpawnersMenuContext = {
  spawners: spawner[];
};

type spawner = {
  name: string;
  amount_left: number;
  desc?: string;
  you_are_text?: string;
  flavor_text?: string;
  important_text?: string;
};

export const SpawnersMenu = (props) => {
  const { act, data } = useBackend<SpawnersMenuContext>();
  const spawners = data.spawners || [];
  return (
    <Window title="Меню перерождения" width={700} height={525}>
      <Window.Content scrollable>
        <Stack vertical>
          {spawners.map((spawner) => (
            <Stack.Item key={spawner.name}>
              <Section
                fill
                // Capitalizes the spawner name
                title={capitalizeAll(spawner.name)}
                buttons={
                  <Stack>
                    <Stack.Item fontSize="14px" color="green">
                      {spawner.amount_left} мест свободно
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        content="Посмотреть"
                        onClick={() =>
                          act('jump', {
                            name: spawner.name,
                          })
                        }
                      />
                      <Button
                        content="Переродиться"
                        onClick={() =>
                          act('spawn', {
                            name: spawner.name,
                          })
                        }
                      />
                    </Stack.Item>
                  </Stack>
                }>
                <LabeledList>
                  {spawner.desc ? (
                    <LabeledList.Item label="Описание">
                      {spawner.desc}
                    </LabeledList.Item>
                  ) : (
                    <div>
                      <LabeledList.Item label="Происхождение">
                        {spawner.you_are_text || 'Неизвестно'}
                      </LabeledList.Item>
                      <LabeledList.Item label="Указания">
                        {spawner.flavor_text || 'Нет'}
                      </LabeledList.Item>
                      <LabeledList.Item color="bad" label="Условия">
                        {spawner.important_text || 'Нет'}
                      </LabeledList.Item>
                    </div>
                  )}
                </LabeledList>
              </Section>
            </Stack.Item>
          ))}
        </Stack>
      </Window.Content>
    </Window>
  );
};
