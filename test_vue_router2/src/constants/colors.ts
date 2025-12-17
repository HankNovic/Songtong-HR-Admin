// 亮色主题颜色
export const LIGHT_COLORS = {
  primary: '#337ab7',
  primaryHover: '#286090',
  danger: '#d9534f',
  success: '#28a745',
  warning: '#ffc107',
  info: '#17a2b8',
  text: '#333',
  textLight: '#fff',
  border: '#ddd',
  bg: '#f5f5f5',
  tableHeaderBg: '#e0e8f0', // 浅灰蓝色
  tableHeaderText: '#333', // 黑色文字
  tableHeaderBorder: '#a0b0c0', // 表头边框颜色（比普通边框更深）
  surface: '#ffffff',
  inputBg: '#ffffff',
  inputText: '#333333',
  inputBorder: '#cccccc',
  tableRowBg: '#ffffff',
  tableRowAltBg: '#f8f9fa',
  tableRowHoverBg: '#e6f0ff',
  shadowSoft: 'rgba(0, 0, 0, 0.45)',
};

// 暗色主题颜色（基础版，可按需微调）
export const DARK_COLORS = {
  primary: '#4da3ff',
  primaryHover: '#1e7ed6',
  danger: '#ff6b6b',
  success: '#51cf66',
  warning: '#ffd43b',
  info: '#63c5da',
  text: '#f1f3f5',
  textLight: '#fff',
  border: '#444',
  bg: '#202225',
  tableHeaderBg: '#2c3136', // 深灰蓝
  tableHeaderText: '#f1f3f5',
  tableHeaderBorder: '#4b5563',
  surface: '#111315',
  inputBg: '#2c3136',
  inputText: '#f1f3f5',
  inputBorder: '#4b5563',
  tableRowBg: '#202225',
  tableRowAltBg: '#181a1f',
  tableRowHoverBg: '#2f343b',
  shadowSoft: 'rgba(255, 255, 255, 0.35)',
};

export type ThemeName = 'light' | 'dark';

// 不同主题下的 CSS 变量映射
export const THEME_COLOR_VARS: Record<ThemeName, Record<string, string>> = {
  light: {
    '--color-primary': LIGHT_COLORS.primary,
    '--color-primary-hover': LIGHT_COLORS.primaryHover,
    '--color-danger': LIGHT_COLORS.danger,
    '--color-success': LIGHT_COLORS.success,
    '--color-warning': LIGHT_COLORS.warning,
    '--color-info': LIGHT_COLORS.info,
    '--color-text': LIGHT_COLORS.text,
    '--color-text-light': LIGHT_COLORS.textLight,
    '--color-border': LIGHT_COLORS.border,
    '--color-bg': LIGHT_COLORS.bg,
    '--color-table-header-bg': LIGHT_COLORS.tableHeaderBg,
    '--color-table-header-text': LIGHT_COLORS.tableHeaderText,
    '--color-table-header-border': LIGHT_COLORS.tableHeaderBorder,
    '--color-surface': LIGHT_COLORS.surface,
    '--color-input-bg': LIGHT_COLORS.inputBg,
    '--color-input-text': LIGHT_COLORS.inputText,
    '--color-input-border': LIGHT_COLORS.inputBorder,
    '--color-table-row-bg': LIGHT_COLORS.tableRowBg,
    '--color-table-row-alt-bg': LIGHT_COLORS.tableRowAltBg,
    '--color-table-row-hover-bg': LIGHT_COLORS.tableRowHoverBg,
    '--color-shadow-soft': LIGHT_COLORS.shadowSoft,
  },
  dark: {
    '--color-primary': DARK_COLORS.primary,
    '--color-primary-hover': DARK_COLORS.primaryHover,
    '--color-danger': DARK_COLORS.danger,
    '--color-success': DARK_COLORS.success,
    '--color-warning': DARK_COLORS.warning,
    '--color-info': DARK_COLORS.info,
    '--color-text': DARK_COLORS.text,
    '--color-text-light': DARK_COLORS.textLight,
    '--color-border': DARK_COLORS.border,
    '--color-bg': DARK_COLORS.bg,
    '--color-table-header-bg': DARK_COLORS.tableHeaderBg,
    '--color-table-header-text': DARK_COLORS.tableHeaderText,
    '--color-table-header-border': DARK_COLORS.tableHeaderBorder,
    '--color-surface': DARK_COLORS.surface,
    '--color-input-bg': DARK_COLORS.inputBg,
    '--color-input-text': DARK_COLORS.inputText,
    '--color-input-border': DARK_COLORS.inputBorder,
    '--color-table-row-bg': DARK_COLORS.tableRowBg,
    '--color-table-row-alt-bg': DARK_COLORS.tableRowAltBg,
    '--color-table-row-hover-bg': DARK_COLORS.tableRowHoverBg,
    '--color-shadow-soft': DARK_COLORS.shadowSoft,
  },
};

// 兼容旧代码：默认导出亮色主题的变量
export const COLOR_VARS: Record<string, string> = THEME_COLOR_VARS.light;

