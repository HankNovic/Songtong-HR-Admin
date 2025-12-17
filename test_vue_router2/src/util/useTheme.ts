import { ref, onMounted } from "vue";
import { THEME_COLOR_VARS, type ThemeName } from "../constants/colors";

const THEME_STORAGE_KEY = "app_theme";

export function applyTheme(theme: ThemeName) {
  const root = document.documentElement;
  const vars = THEME_COLOR_VARS[theme];

  Object.entries(vars).forEach(([key, value]) => {
    root.style.setProperty(key, value);
  });

  root.setAttribute("data-theme", theme);
}

export function getInitialTheme(): ThemeName {
  if (typeof window === "undefined") return "light";
  const saved = window.localStorage.getItem(THEME_STORAGE_KEY);
  if (saved === "light" || saved === "dark") {
    return saved;
  }
  // 如果没有手动选择，可以根据系统偏好做一个默认
  if (window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) {
    return "dark";
  }
  return "light";
}

export function useTheme() {
  const theme = ref<ThemeName>(getInitialTheme());

  onMounted(() => {
    applyTheme(theme.value);
  });

  const toggleTheme = () => {
    theme.value = theme.value === "light" ? "dark" : "light";
    if (typeof window !== "undefined") {
      window.localStorage.setItem(THEME_STORAGE_KEY, theme.value);
    }
    applyTheme(theme.value);
  };

  return {
    theme,
    toggleTheme,
  };
}


