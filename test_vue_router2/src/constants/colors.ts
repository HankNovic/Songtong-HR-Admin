export const COLORS = {
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
  tableHeaderBg: '#fafafa',
  tableHeaderText: '#555',
};

// 可选：导出一份 CSS 变量映射，方便挂到 root 上使用
export const COLOR_VARS: Record<string, string> = {
  '--color-primary': COLORS.primary,
  '--color-primary-hover': COLORS.primaryHover,
  '--color-danger': COLORS.danger,
  '--color-success': COLORS.success,
  '--color-warning': COLORS.warning,
  '--color-info': COLORS.info,
  '--color-text': COLORS.text,
  '--color-text-light': COLORS.textLight,
  '--color-border': COLORS.border,
  '--color-bg': COLORS.bg,
  '--color-table-header-bg': COLORS.tableHeaderBg,
  '--color-table-header-text': COLORS.tableHeaderText,
};

