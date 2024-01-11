import { useBackend } from '../backend';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from '../components';
import { Window } from '../layouts';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';

export const Apc = (props) => {
  return (
    <Window width={450} height={445}>
      <Window.Content scrollable>
        <ApcContent />
      </Window.Content>
    </Window>
  );
};

const powerStatusMap = {
  2: {
    color: 'good',
    externalPowerText: 'Внешнее питание',
    chargingText: 'Полностью заряжен',
  },
  1: {
    color: 'average',
    externalPowerText: 'Низкое внешнее питание',
    chargingText: 'Зарядка',
  },
  0: {
    color: 'bad',
    externalPowerText: 'Нет внешнего питания',
    chargingText: 'Не заряжается',
  },
};

const malfMap = {
  1: {
    icon: 'terminal',
    content: 'Override Programming',
    action: 'hack',
  },
  2: {
    icon: 'caret-square-down',
    content: 'Shunt Core Process',
    action: 'occupy',
  },
  3: {
    icon: 'caret-square-left',
    content: 'Return to Main Core',
    action: 'deoccupy',
  },
  4: {
    icon: 'caret-square-down',
    content: 'Shunt Core Process',
    action: 'occupy',
  },
};

const ApcContent = (props) => {
  const { act, data } = useBackend();
  const locked = data.locked && !data.siliconUser;
  const externalPowerStatus =
    powerStatusMap[data.externalPower] || powerStatusMap[0];
  const chargingStatus =
    powerStatusMap[data.chargingStatus] || powerStatusMap[0];
  const channelArray = data.powerChannels || [];
  const malfStatus = malfMap[data.malfStatus] || malfMap[0];
  const adjustedCellChange = data.powerCellStatus / 100;
  if (data.failTime > 0) {
    return (
      <NoticeBox info textAlign="center" mb={0}>
        <b>
          <h3>СИСТЕМНЫЙ СБОЙ</h3>
        </b>
        I/O регуляторы вышли из строя! <br />
        Ожидание перезагрузки системы.
        <br />
        Executing software reboot in {data.failTime} seconds...
        <br />
        <br />
        <Button
          icon="sync"
          content="Перезагрузить"
          tooltip="Принудительная перезагрузка интерфейса."
          tooltipPosition="bottom"
          onClick={() => act('reboot')}
        />
      </NoticeBox>
    );
  }
  return (
    <>
      <InterfaceLockNoticeBox
        siliconUser={data.remoteAccess || data.siliconUser}
        preventLocking={data.remoteAccess}
      />
      <Section title="Состояние питания">
        <LabeledList>
          <LabeledList.Item
            label="Главный выключатель"
            color={externalPowerStatus.color}
            buttons={
              <Button
                icon={data.isOperating ? 'power-off' : 'times'}
                content={data.isOperating ? 'Вкл' : 'Выкл'}
                selected={data.isOperating && !locked}
                disabled={locked}
                onClick={() => act('breaker')}
              />
            }
          >
            [ {externalPowerStatus.externalPowerText} ]
          </LabeledList.Item>
          <LabeledList.Item label="Батарея питания">
            <ProgressBar color="good" value={adjustedCellChange} />
          </LabeledList.Item>
          <LabeledList.Item
            label="Режим зарядки"
            color={chargingStatus.color}
            buttons={
              <Button
                icon={data.chargeMode ? 'sync' : 'times'}
                content={data.chargeMode ? 'Авто' : 'Выкл'}
                disabled={locked}
                onClick={() => act('charge')}
              />
            }
          >
            [ {chargingStatus.chargingText} ]
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Каналы питания">
        <LabeledList>
          {channelArray.map((channel) => {
            const { topicParams } = channel;
            return (
              <LabeledList.Item
                key={channel.title}
                label={channel.title}
                buttons={
                  <>
                    <Box
                      inline
                      mx={2}
                      color={channel.status >= 2 ? 'good' : 'bad'}
                    >
                      {channel.status >= 2 ? 'Вкл' : 'Выкл'}
                    </Box>
                    <Button
                      icon="sync"
                      content="Авто"
                      selected={
                        !locked &&
                        (channel.status === 1 || channel.status === 3)
                      }
                      disabled={locked}
                      onClick={() => act('channel', topicParams.auto)}
                    />
                    <Button
                      icon="power-off"
                      content="Вкл"
                      selected={!locked && channel.status === 2}
                      disabled={locked}
                      onClick={() => act('channel', topicParams.on)}
                    />
                    <Button
                      icon="times"
                      content="Выкл"
                      selected={!locked && channel.status === 0}
                      disabled={locked}
                      onClick={() => act('channel', topicParams.off)}
                    />
                  </>
                }
              >
                {channel.powerLoad}
              </LabeledList.Item>
            );
          })}
          <LabeledList.Item label="Общая нагрузка">
            <b>{data.totalLoad}</b>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title="Прочие"
        buttons={
          !!data.siliconUser && (
            <>
              {!!data.malfStatus && (
                <Button
                  icon={malfStatus.icon}
                  content={malfStatus.content}
                  color="bad"
                  onClick={() => act(malfStatus.action)}
                />
              )}
              <Button
                icon="lightbulb-o"
                content="Избыток"
                onClick={() => act('overload')}
              />
            </>
          )
        }
      >
        <LabeledList>
          <LabeledList.Item
            label="Блокировка крышки"
            buttons={
              <Button
                tooltip="Крышку ЛКП можно открыть с помощью ломика."
                icon={data.coverLocked ? 'lock' : 'unlock'}
                content={data.coverLocked ? 'Задействован' : 'Отключен'}
                disabled={locked}
                onClick={() => act('cover')}
              />
            }
          />
          <LabeledList.Item
            label="Аварийная подсветка"
            buttons={
              <Button
                tooltip="При отсутствии питания лампочки используют внутренний элемент питания."
                icon="lightbulb-o"
                content={data.emergencyLights ? 'Включено' : 'Отключено'}
                disabled={locked}
                onClick={() => act('emergency_lighting')}
              />
            }
          />
          <LabeledList.Item
            label="Освещение в темное время"
            buttons={
              <Button
                tooltip="Уменьшение яркости освещения для снижения энергопотребления."
                icon="lightbulb-o"
                content={data.nightshiftLights ? 'Включено' : 'Отключено'}
                disabled={data.disable_nightshift_toggle}
                onClick={() => act('toggle_nightshift')}
              />
            }
          />
        </LabeledList>
      </Section>
    </>
  );
};
