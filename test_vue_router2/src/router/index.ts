// history模式
import {
    createRouter, createWebHistory
} from 'vue-router'

const routes = [
    {
        path: "/",
        name: "Index",
        component: () =>
            import( "../components/Index.vue"),
        children: [
            {
                path: "/emp/show",
                name: "EmpShow",
                component: () =>
                    import( "../components/employee/Show.vue")
            },
            {
                path: "/emp/add",
                name: "EmpAdd",
                component: () =>
                    import( "../components/employee/Add.vue")
            },
            {
                path: "/emp/update",
                name: "EmpUpdate",
                component: () =>
                    import( "../components/employee/Update.vue")
            }
        ]
    }
];

// 创建路由对象
const router = createRouter({
    history: createWebHistory(),
    routes
})
export default router;    