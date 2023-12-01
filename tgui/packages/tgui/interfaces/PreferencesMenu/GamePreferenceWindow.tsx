import { Stack } from '../../components';
import { Window } from '../../layouts';
import { KeybindingsPage } from './KeybindingsPage';
import { GamePreferencesPage } from './GamePreferencesPage';
import { PageButton } from './PageButton';
import { useBackend, useLocalState } from '../../backend';
import { GamePreferencesSelectedPage, PreferencesMenuData } from './data';
import { exhaustiveCheck } from 'common/exhaustive';

export const GamePreferenceWindow = (props: {
  startingPage?: GamePreferencesSelectedPage;
}) => {
  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPage, setCurrentPage] = useLocalState(
    'currentPage',
    props.startingPage ?? GamePreferencesSelectedPage.Settings
  );

  let pageContents;

  switch (currentPage) {
    case GamePreferencesSelectedPage.Keybindings:
      pageContents = <KeybindingsPage />;
      break;
    case GamePreferencesSelectedPage.Settings:
      pageContents = <GamePreferencesPage />;
      break;
    default:
      exhaustiveCheck(currentPage);
  }

  return (
    <Window title="Игровые параметры" width={920} height={770}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Stack fill>
              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={GamePreferencesSelectedPage.Settings}
                  setPage={setCurrentPage}>
                  Настройки
                </PageButton>
              </Stack.Item>

              <Stack.Item grow>
                <PageButton
                  currentPage={currentPage}
                  page={GamePreferencesSelectedPage.Keybindings}
                  setPage={setCurrentPage}>
                  Привязки клавиш
                </PageButton>
              </Stack.Item>
            </Stack>
          </Stack.Item>

          <Stack.Divider />

          <Stack.Item grow shrink basis="1px">
            {pageContents}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
