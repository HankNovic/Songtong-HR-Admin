// history模式
import {
    createRouter, createWebHistory
} from 'vue-router'
import { useAuth } from '../stores/auth';

const routes = [
    {
        path: "/login",
        name: "Login",
        component: () =>
            import("../components/Login.vue"),
        meta: { requiresAuth: false, title: "登录" }
    },
    {
        path: "/",
        name: "Index",
        component: () =>
            import("../components/Index.vue"),
        meta: { requiresAuth: true, title: "首页" },
        children: [
            {
                path: "/emp/show",
                name: "EmpShow",
                component: () =>
                    import("../components/employee/Show.vue"),
                meta: { permission: 'employee', title: "员工管理" }
            },
            {
                path: "/emp/add",
                name: "EmpAdd",
                component: () =>
                    import("../components/employee/Add.vue"),
                meta: { permission: 'employee', title: "员工添加" }
            },
            {
                path: "/emp/update",
                name: "EmpUpdate",
                component: () =>
                    import("../components/employee/Update.vue"),
                meta: { permission: 'employee', title: "员工修改" }
            },
            {
                path: "/dep/show",
                name: "DepShow",
                component: () =>
                    import("../components/department/Show.vue"),
                meta: { permission: 'department', title: "部门管理" }
            },
            {
                path: "/dep/add",
                name: "DepAdd",
                component: () =>
                    import("../components/department/Add.vue"),
                meta: { permission: 'department', title: "部门添加" }
            },
            {
                path: "/dep/update",
                name: "DepUpdate",
                component: () =>
                    import("../components/department/Update.vue"),
                meta: { permission: 'department', title: "部门修改" }
            },
            {
                path: "/sysUser/show",
                name: "SysUserShow",
                component: () =>
                    import("../components/sysUser/Show.vue"),
                meta: { permission: 'sysUser', title: "用户管理" }
            },
            {
                path: "/sysRole/show",
                name: "SysRoleShow",
                component: () =>
                    import("../components/sysRole/Show.vue"),
                meta: { permission: 'sysRole', title: "角色管理" }
            },
            {
                path: "/sysPermission/show",
                name: "SysPermissionShow",
                component: () =>
                    import("../components/sysPermission/Show.vue"),
                meta: { permission: 'sysPermission', title: "权限管理" }
            }
        ]
    }
];

// 创建路由对象
const router = createRouter({
    history: createWebHistory(),
    routes
});

// 路由守卫
router.beforeEach((to, _from, next) => {
    const auth = useAuth();
    
    // 恢复登录状态
    auth.restoreAuth();
    
    // 检查是否需要登录
    if (to.meta.requiresAuth && !auth.isAuthenticated.value) {
        next('/login');
        return;
    }
    
    // 如果已登录，访问登录页则跳转到首页
    if (to.path === '/login' && auth.isAuthenticated.value) {
        next('/');
        return;
    }
    
    // 检查权限
    if (to.meta.permission && !auth.hasPermission(to.meta.permission as string)) {
        // 没有权限，跳转到首页或显示提示
        alert('您没有访问该页面的权限');
        next('/');
        return;
    }

    // 设置页面 title
    const baseTitle = '松桐人事管理系统';
    const routeTitle = (to.meta as any)?.title as string | undefined;
    if (routeTitle) {
        document.title = `${baseTitle} - ${routeTitle}`;
    } else {
        document.title = baseTitle;
    }

    next();
});

export default router;    