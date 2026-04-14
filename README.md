# Minimal Modular Flake Demo

这是一个最小可用的 NixOS 模块化 Flake 示范配置。

它刻意把业务内容压缩到最低，只保留框架能力：

- `flake.nix` 作为统一入口
- `lib/` 提供自定义工具函数
- `modules/default.nix` 自动导入模块
- `demo.*` 作为自定义命名空间
- 一个普通模块样例：`cli/git.nix`
- 一个 preset 样例：`presets/development.nix`
- `hosts/laptop` 作为主机实例层
- `home-manager` 作为用户态配置桥接层
- `addHost` 只负责主机装配

## 目录

```text
examples/minimal-framework/
├── flake.nix
├── lib/
│   └── default.nix
├── modules/
│   ├── default.nix
│   ├── home.nix
│   ├── cli/
│   │   └── git.nix
│   └── presets/
│       └── development.nix
└── hosts/
    └── laptop/
        ├── default.nix
        └── hardware.nix
```

## 保留了哪些功能

- 自定义命名空间：`demo.*`
- 模块自动注册
- 单模块启用与参数传递
- preset 组合模块
- host 层只做选择和覆盖
- Home Manager 配置桥接
- 用户名保留为正式 option：`demo.user.name`
- `stateVersion` 和用户名由 host 显式声明

## 现在的组织方式

- `flake.nix` 里的 `addHost` 只负责装配 `modules/` 和 `hosts/<name>`
- `system.stateVersion` 在 host 中显式声明
- `demo.user.name` 也在 host 中显式赋值
- host 文件同时承担共享值和主机差异声明

## 当前示例

```nix
laptop = addHost {
  hostName = "laptop";
};
```

主机自己的值写在：

```nix
system.stateVersion = "24.11";
demo.user.name = "demo";
```

## 使用方式

进入目录后执行：

```sh
sudo nixos-rebuild switch --flake .#laptop
```

如果只是验证求值：

```sh
nix flake show
nix eval .#nixosConfigurations.laptop.config.demo.cli.git.enable
```
