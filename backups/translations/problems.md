## 桌面 Linux 的问题和主要缺点

所以 Linux 不好的原因是 ...

+ **硬件支持:**

  1. 显卡硬件加速 (另见 X system 小节)。

    +  ! 大多数笔记本中所使用的 NVIDIA Optimus 技术并不能很好地在 Linux 发挥作用。人们为画面撕裂和新内核版本等苦苦挣扎。
    +  ! 开源驱动有着某些、有时非常严重的问题 (Intel-! 和 AMD):
       +  ! 由于电源管理不完善，开源  NVIDIA 驱动要比其专有驱动慢得多（最多二十倍，这完全是 NVIDIA 的错误，它拒绝为 Nouveau 项目提供所需的固件）。
       +  ! 开源 NVIDIA 驱动 Nouveau 不能正确地、完全地支持电源管理功能和风扇速度管理（这也几乎是 NVIDIA 的错）。
       +  ! 专有的 NVIDIA 驱动程序有一个使 GPU 保持最高性能水平的讨厌习惯，这会显著增加功耗，并且对于移动用户，会显著缩短电池寿命。NVIDIA在 2017 年 7 月意识到这个问题，但尽管他们在 2019 年进行了改进，问题仍然存在。
    + !! 根据一名不愿透露姓名的 NVIDIA 工程师所述：“几乎每个游戏都会崩溃……在某些情况下，我们谈论的是公然违反 API 规则的行为……驱动程序中已经有很多可选补丁，可以根据游戏设置简单地打开或关闭它们，然后有专门针对游戏的破解 ...（大家）曾经都想知道为什么几乎每个主要游戏版本都随附有来自 AMD 和/或 NVIDIA 的匹配驱动程序版本？” 开源社区根本没有资源来实现类似的破解来修复损坏的游戏，这意味着至少对于复杂的 3A 游戏，专有驱动程序将仍然是唯一的选择。
  +  ! 对于非标准分辨率、超高分辨率（又叫 HiDPI）或自定义刷新率的支持，Linux 驱动通常比 Windows/macOS 的表现更糟糕（这些驱动需要很多修补工作，换句话说：需要很多人工配置）。
  +  ! 在 Linux 下，要设置设定多显示器配置、尤其是使用多 GPU 运行二进制 NVIDIA 驱动，过程可以说相当让人讨厌。
     (对于大多数用户不是问题但仍旧是个问题：）NVIDIA GPU 很可能永远不会支持 GPU 电压调节，这意味着没有恰当的方式去超频，或者降频来节省电量。
     + !! 用于监视和控制 GPU 参数（例如频率，电压和风扇曲线，类似于 Windows 中的 MSI Afterburner 或 GPU-Z），性能显示图层（Fraps、RivaTuner Statistics Server），录制游戏会话和流媒体的工具的开发状态和可用性极差。

  2. 音频子系统:

    + PulseAudio 不太适合多用户模式 - 是的，很多人会共享他们的电脑 （这里有个未经测试的解决方案）。 
    + ! No reliable echo cancellation (if you use a normal microphone and speakers in many cases you won't be able to use Skype and other VoIP services normally). Windows, Android and MacOS implement it on a system level. There's a solution for PulseAudio - hopefully it'll be enabled by default in the future or/and there'll be an easier way to use it.
    + Hardly a dealbreaker but then audio professionals also want to use Linux: high definition audio support (>=96KHz, >=24bit) is usually impossible to set up without using console.
    + Various audio effects like volume normalization are not included or enabled by default by most distros.

  3. Printers, scanners and other more or less peripheral devices:

  + There are still many printers which are not supported at all or only barely supported - some people argue that the user should research Linux compatibility before buying their hardware. What if the user decides to switch from Windows to Linux when he/she already has some hardware? When people purchase a Windows PC do they research anything? No, they rightly assume everything will work out of the box right from the get-go.
  + Many printer's features are only implemented in Windows drivers.
  + Some models of scanners and (web-)cameras are still inadequately supported (again many features from Windows drivers are missing) or not supported at all.
  + Incomplete or unstable drivers for some hardware. Problems setting up some hardware (like touchpads in newest laptops, web cameras or Wi-Fi cards, for instance, 802.11ac and USB Wi-Fi adapters are barely supported under Linux and in many cases they are just unusable). Broadcom network adapters are often usable out of the box for a lot of Linux distors (to be honest the company seemingly hates Open Source).

  4. Laptops, tablets, 2 in 1 devices, etc.:

  + Incomplete or missing support for certain power-saving features modern laptops employ (like e.g. PCIe ASPM, proper video decoding acceleration, deep power-saving states, etc.) thus under Linux you won't get the same battery life as under Windows or MacOS and your laptop will run a lot hotter. Jupiter (discontinued unfortunately), see Advanced Power Management for Linux. Edit July 19, 2018: If you're running supported hardware with Fedora 28 and Linux 4.17 and later, power management must be excellent under Linux aside from watching videos (both online and offline: video decoding acceleration in Linux is still a very sad story).
  + !! Oftentimes you just cannot use new portable devices in Linux because proper support for certain features gets impletemented too late and distros pick up this support even later.
  + Laptops/notebooks often have special buttons and features that don't work (e.g. Fn + F1-F12 combination or special power-saving modes).

  5.  ! Resume after suspend in Linux is unstable and oftentimes doesn't work.
  6.  ! Often regressions are introduced in the Linux kernel, when some hardware stops working inexplicably in new kernel versions. I have personally reported two serious audio playback regressions, which have been consequently resolved, however most users don't know how to file bugs, how to bisect regressions, how to identify faulty components.

+ **Software support:**
  1. X system (current primary video output server in Linux):
    + X.org is largely outdated, unsuitable and even very much insecure for modern PCs and applications.
    + No high level, stable, sane (truly forward and backward compatible) and standardized API for developing GUI applications (like core Win32 API - most Windows 95 applications still run fine in Windows 10 - that's 24 years of binary compatibility). Both GTK and Qt (incompatible GTK versions 1, 2, 3, 4 and incompatible Qt versions 4, 5, 6 just for the last decade) don't strive to be backwards compatible. The Qt company also changed the licensing model for their toolkit which makes using the library under Linux problematic to say the least.
    + ! Keyboard shortcut handling for people using local keyboard layouts is broken (this bug is now **15 years old**).
    + ! X.org doesn't automatically switch between desktop resolutions if you have a full screen application with a custom resolution running - strangely some Linux developers oppose to the whole idea of games on Linux. But since Linux is not a gaming platform and no one is interested in Linux as a gaming platform this problem's importance is debatable. Valve has released Steam for Linux and they are now porting their games for Linux - but that's a drop in the bucket.
    + ! X.org doesn't restore gamma (which can be perceived as increased brightness) settings on application exit. If you play Valve/Wine games and experience this problem run `xgamma -1` in a terminal. You can thank me by clicking the ad at the top of the page ;-)
    + ! Scrolling in various applications causes artifacts.
    + ! X.org allows applications to exclusively grab keyboard and mouse input. If such applications misbehave you are left with a system you cannot manage, you cannot even switch to text terminals.
    + ! Keyboard handling in X.org is broken by design - when you have a pop up or an open menu, global keyboard shortcuts/​keybindings don't (GTK) work (QT).
    + ! For VM applications keyboard handling is incomplete and passing keypresses to guest OS'es is outright broken.
    + ! X.org architecture is inherently insecure - even if you run a desktop GUI application under a different user in your desktop session, e.g. using sudo and xhost, then that "foreign" application can grab any input events and also make screenshots of the entire screen.
    + ! X.org server currently has no means of permanently storing and restoring settings changed by the user (xrender settings, Xv settings, etc.). NVIDIA and ATI proprietary drivers both employ custom utilities for this purpose.
    + !! X.org has no means of providing a tear-free experience, it's only available if you're running a compositing window manager in the OpenGL mode with vsync-to-blank enabled.
    + !! X.org is not multithreaded. Certain applications running intensive graphical operations can easily freeze your desktop (a simple easily reproducible example: run Adobe Photoshop 7.0 under Wine, open a big enough image and apply a sophisticated filter - see your graphical session die completely until Photoshop finishes its operation).
    + ! There's currently no way to configure mouse scroll speed/acceleration under X.org. Some mice models scroll erratically under X.org.
    + There's no way to replace/​upgrade/​downgrade X.org graphics drivers on the fly (simply put - to restart X server while retaining a user session and running applications).
    + No true safe mode for the X.org server (likewise for KMS - read below). Misconfiguration and broken drivers can leave you with a non-functional system, where sometimes you cannot access text virtual consoles to rectify the situation (in 2013 it became almost a non-issue since quite often nowadays X.org no longer drives your GPU - the kernel does that via KMS).
    + Adding custom monitor modelines in Linux is a major PITA.
    + X.org does not support different scaling modes for different monitors.
    + X.org totally sucks (IOW doesn't work at all in regard to old applications) when it comes to supporting tiled displays, for instance 4K displays (Dell UP3214Q, Dell UP2414Q, ASUS PQ321QE, Seiko TVs and others). This is yet another architectural limitation.
    + HiDPI support is often a huge issue (many older applications don't scale at all).
    + ! Fast user-switching (and also concurrent users' sessions) under X.org works very badly and is implemented as a dirty hack: for every user a new X.org server is started. It's possible to login twice under the same account while not being able to run many applications due to errors caused by concurrent access to the same files. Fast user switching is best implemented in KDE followed by Gnome.

    Related problems:
    1) Concurrently logged in users cannot access the same USB flash drive(s).
    2) There are reports that problems exists with configuring audio mixer volume levels.
  
  2. Wayland:
  
    + !! Applications (or GUI toolkits) must implement their own font antialiasing - there's no API for setting system-wide font rendering. Most sane and advanced windowing systems work exactly this way - Windows, Android, Mac OS X. In Wayland all clients (read applications) are totally independent.
    + !! Applications (or GUI toolkits) must implement their own DPI scaling.
    + The above issues are actually the result of not having one unified graphical toolkit/API (and Wayland developers will not implement it). Alas, no one is currently working towards making existing toolkits share one common configuration for setting font antialiasing, DPI scaling and windows shadowing. At least in theory these issues can be easily solved, in practice we already have three independent toolkits for Wayland (GTK3/Qt5/Enlightenment).
    + !! Wayland works through rasterization of pixels which brings about two very bad critical problems which will never be solved:
      
      Firstly, forget about performance/bandwidth efficient RDP protocol (it's already implemented but it works by sending the updates of large chunks of the screen, i.e. a lot like old highly inefficient VNC), forget about OpenGL pass-through, forget about raw compressed video pass-through. In case you're interested all these features work in Microsoft's RDP.
      
      Secondly, forget about proper output rotation/scaling/ratio change.
    + !! Wayland doesn't allow XWayland applications to change display resolution which could make running games slower as the compositor needs to upscale each game frame. Also software upscaling might not be the best option.
    + !! Screensharing doesn't yet work out of the box (likely to be fixed in 2020).
    + !! Wayland lacks APIs for global keyboard shortcuts.
    + !! Wayland doesn't allow applications to exclusively grab mouse/keyboard which is required for games and applications like VMs.
    + !! Wayland lacks APIs for sending remote input which makes Wayland unsuitable for remote desktoping.
    + !! Applies to the X server/protocol as well: neither X.org, nor Wayland offer a way to extend/modify window's title bars and File Open/Save dialogs. This is a very powerful feature which can be very useful in many situations. Again it's a result of the fact that there's no unified toolkit and no unified window manager (or protocol).
    + !! Wayland compositors don't have a universal method of storing and configuring screen/session/keyboard/mouse settings.
    + Currently there's no standard way to remap keys under Wayland.
    + XWayland refresh rate is locked to 60Hz - that's actually a serious problem since most games for Linux use the X11 protocol.
    + Wayland applications cannot run without a Wayland compositor and in case it crashes, all the running apps die. Under X.org/Microsoft Windows there's no such issue.
    + An assortment of various other general and KDE specific issues.
  3. Font rendering (which is implemented via high level GUI libraries) issues:
    + ! ClearType fonts are not properly supported out of the box. Even though the ClearType font rendering technology is now supported, you have no means of properly tuning it thus ClearType fonts from Windows look ugly.
    + Quite often default fonts look ugly, due to missing good (catered to the LCD screen - subpixel RGB full hinting) default fontconfig settings.
    + Font antialiasing settings cannot be applied on-the-fly under many DEs. This issue is impossible to solve unless we have a high level GUI library which is shared between all tooklits and desktop environments.
  4. The Linux kernel:
    + ! The kernel cannot recover from video, sound and network drivers' crashes (I'm very sorry for drawing a comparison with Windows Vista/7/8/10 where this feature has been implemented for ages and works beautifully in a lot of cases).
    + KMS exclusively grabs video output and disallows VESA graphics modes (thus it's impossible to switch different versions of graphics drivers on the fly).
    + KMS video drivers cannot be unloaded or reloaded.
    + !! KMS has **no safe mode**: sometimes KMS cannot properly initialize your display and you have a dead system you cannot access at all (a kernel option "nomodeset" can save you, but it prevents KMS drivers from working at all - so either you have 80x25 text console or you have a perfectly dead display).
    + Traditional Linux/Unix (ext4/​reiser/​xfs/​jfs/​btrfs/etc.) filesystems can be problematic when being used on mass media storage.
    + File descriptors and network sockets cannot be forcibly closed - it's indeed unsafe to remove USB sticks without unmounting them first as it leads to stale mount points, and in certain cases to oopses and crashes. For the same reason you cannot modify your partitions table and resize/move the root partition on the fly.
    + In most cases kernel crashes (= panics) are invisible if you are running an X session. Moreover KMS prevents the kernel from switching to plain 640x480 or 80x25 (text) VGA modes to print error messages. As of 2020 there's work underway to implement kernel error logging under KMS.
    + !! Very incomplete hardware sensors support, for instance, HWiNFO64 detects and shows ten hardware sensor sources on my average desktop PC and over fifty sensors, whilst lm-sensors detect and present just four sources and twenty sensors. This situation is even worse on laptops - sometimes the only readings you get from lm-sensors are cpu cores' temperatures.
    + ! A number (sometimes up to dozens) of regressions in every kernel release due to the inability of kernel developers to test their changes on all possible software and hardware configurations. Even "stable" x.y.Z kernel updates sometimes have serious regressions.
    + ! The Linux kernel is extremely difficult and cumbersome to debug even for the people who develop it.
    + Under some circumstances the system or X.org's GUI may become very slow and unresponsive due to various problems with video acceleration or lack of it and also due to notorious bug 12309 - it's ostensibly fixed but some people still experience it). This bug can be easily reproduced under Android (which employs the Linux kernel) even in 2020: run any disk intensive application (e.g. under any Android terminal 'cat /dev/zero > /sdcard/testfile') and enjoy total UI unresponsiveness.
    + !! Critical bug reports filed against the Linux kernel often get zero attention and may linger for years before being noticed and resolved. Posts to LKML oftentimes get lost if the respective developer is not attentive or is busy with his own life.
    + The Linux kernel contains a whole lot of very low quality code and when coupled with unstable APIs it makes development for Linux a very difficult error prone process.
    + The Linux kernel forbids to write to CPU MSRs in secure UEFI mode which makes it impossible to fine-tune your CPU power profile. This is perfectly possible under Windows 10.
    + Memory management under Linux leaves a lot to be desired: under low memory conditions your system may become completely unresponsive. This can be alleviated by certain user-space daemons like earlyoom.
  5. Problems stemming from the vast number of Linux distributions:
    + ! No unified configuration system for various system daemons, computer settings and devices. The issue has been more or less solved in regard to network settings (after distors standardized on NetworkManager) and system services (due to systemd which has become a standard).
    + ! No unified installer/package manager/universal packaging format/dependency tracking across all distros (The GNU Guix project, which is meant to solve this problem, is now under development - but we are yet to see whether it will be incorporated by major distros). Consider RPM (which has several incompatible versions, yeah), deb, portage, tar.gz, sources, etc. It adds to the cost of software development.
    + ! Distros' repositories do not contain all available open source software (libraries' conflicts don't even allow that luxury). The user should never be bothered with using ./configure && make && make install (besides, it's insecure, can break things in a major way, and it sometimes simply doesn't work because the user cannot install/configure dependencies properly). It should be possible to install any software by downloading a package and double clicking it (yes, like in Windows, but probably prompting for a user/administrator password). Linux distros. ©2000 Microsoft Germany [Microsoft_Linux_ad]
    + ! Applications development is a major PITA. Different distros can use a) different library versions, b) different compiler flags, c) different compilers. This leads to a number of problems raised to the third power. Packaging all dependent libraries is not a solution, because in this case your application may depend on older versions of libraries which contain serious remotely exploitable vulnerabilities.
    + ! Two most popular open source desktops, KDE and Gnome, can configure only a few settings by themselves thus each distro creates its own bicycle (applications/utilities) for configuring a boot loader/​firewall/​users and groups, services, etc.
    + Linux is a hell for ISP/ISV support personnel. Within the organization you can force a single distro on anyone, but it cannot be accomplished when your clients have the freedom to choose.
  6. Linux as a gaming platform issues (it's great we now have Proton/Wine/DXVK but):
    + ! No plug-and-play support for a lot of input devices like joysticks and steering wheels. Many require editing of cryptic configuration files.
    + ! No universal simple to use GUI application which implements an on-screen HUD with CPU, GPU, RAM use, FPS and frame timing. A number of half-solutions exist, including using environment variables but they are not user-friendly. Luckily there's MangoHud which is yet to be included by major Linux distros and which is lacking GUI for configuration. At least it works and exists.
    + ! No universal vendor-neutral alternative to MSI Afterburner - an app for monitoring, overclocking, downclocking/undervolting your GPU.
    + ! Many anti-cheat protections fail to work under Linux. Besides in Linux it's near impossible to guarantee that game assets haven't been tinkered with (think of transparent walls for first-person competitive shooters like Counter Strike Global Offensive, Valorant or Apex Legends).
    + ! No advanced Windows drivers features, like NVIDIA FreeStyle, low-latency input, FPS limiting, half VSync refresh rate and many many others.
    + ! Performance/smoothness/stuttering issues due to the translation overhead between Win32 APIs/Direct3D and Linux APIs/Vulkan.
  7. ! It should be possible to configure pretty much everything via GUI (in the end Windows and Mac OS allow this) which is still not a case for some situations and operations.
  8. No polish and universally followed conventions. Different applications may have totally different shortcuts for the same actions, UI elements may be placed and look differently.
  
+ Problems stemming from low Linux popularity and open source nature:
  1. ! Few software titles, inability to run familiar Windows software (some applications which don't work in Wine - look at the lines which contain the word "regression" - have zero Linux equivalents).
  2. ! No equivalent of some hardcore Windows software like ArchiCAD, 3ds Max, Adobe products like Premier and Photoshop, Corel Draw, Quicken, video authoring applications/etc. Home and enterprise users just won't bother installing Linux until they can get their work done.
  3. ! A small number of native games and few native AAA games for the past six years. The number of available Linux games overall is less than 10% of games for Windows. Steam shows a better picture: 25% of games over there have Linux ports (in February 2020: Windows 69601 titles vs. Linux 13666 titles) but over 98% out of them are Indies; i.e. AAA titles, especially the recent ones, are a rarity in Linux. Luckily nowadays it's possible to run a large number of Windows games in Wine/DXVK and Steam/Proton.
  4. Questionable patents and legality status. USA Linux users in 2020 cannot play many popular audio and video formats until they purchase appropriate codecs or enable third-party repos.
+ General Linux problems:
  1. !! There's no concept of drivers in Linux aside from proprietary drivers for NVIDIA/AMD GPUs which are separate packages: almost all drivers are already either in the kernel or various complementary packages (like foomatic/sane/etc). It's impossible for the user to understand whether their hardware is indeed supported by the running Linux distro and whether all the required drivers are indeed installed and working properly (e.g. all the firmware files are available and loaded or necessary printer filters are installed).
  2. !! There's no guarantee whatsoever that your system will (re)boot successfully after GRUB (bootloader) or kernel updates - sometimes even minor kernel updates break the boot process (except for Windows 10 - but that's a new paradigm for Microsoft). For instance Microsoft and Apple regularly update ntoskrnl.exe and mach_kernel respectively for security fixes, but it's unheard of that these updates ever compromised the boot process. GRUB updates have broken the boot process on the PCs around me at least ten times. (Also see compatibility issues below).
  3. !! LTS distros are unusable on the desktop because they poorly support or don't support new hardware, specifically GPUs (as well as Wi-Fi adapters, NICs, sound cards, hardware sensors, etc.). Oftentimes you cannot use new software in LTS distros (normally without miscellaneous hacks like backports, PPAs, chroots, etc.), due to outdated libraries. A not so recent example is Google Chrome on RHEL 6/CentOS 6.
  4. !! Linux developers have a tendency to a) suppress news of security holes b) not notify the public when the said holes have been fixed c) miscategorize arbitrary code execution bugs as "possible denial of service" (thanks to Gullible Jones for reminding me of this practice - I wanted to mention it aeons ago, but I kept forgetting about that).

    Here's a full quote by Torvalds himself: "So I personally consider security bugs to be just "normal bugs". I don't cover them up, but I also don't have any reason what-so-ever to think it's a good idea to track them and announce them as something special."
      
    Year 2014 was the most damning in regard to Linux security: critical remotely-exploitable vulnerabilities were found in many basic Open Source projects, like bash (shellshock), OpenSSL (heartbleed), kernel and others. So much for "everyone can read the code thus it's invulnerable". In the beginning of 2015 a new critical remotely exploitable vulnerability was found, called GHOST.
      
    Year 2015 welcomed us with **134 vulnerabilities** in one package alone: WebKitGTK+ WSA-2015-0002. I'm not implying that Linux is worse than Windows/MacOS proprietary/closed software - I'm just saying that the mantra that open source is more secure by definition because everyone can read the code is apparently totally wrong.
      
    Year 2016 pleased us with several local root Linux kernel vulnerabilities as well as countless other critical vulnerabilities. In 2016 Linux turned out to be significantly more insecure than often-ridiculed and laughed-at Microsoft Windows.
      
    The Linux kernel consistently remains one of the most vulnerable pieces of software in the entire world. In 2017 it had 453 vulnerabilities vs. 268 in the entire Windows 10 OS. No wonder Google intends to replace Linux with its own kernel.
      
    Many Linux developers are concerned with the state of security in Linux because it is simply lacking.
  5. (GI) Linux servers might be a lot less secure than ... Windows servers, "The vast majority of webmasters and system administrators have to update their software manually and test that their infrastructure works correctly".
     
  
    Seems like there are lots of uniquely gifted people out there thinking I'm an idiot to write about this. Let me clarify this issue: whereas in Windows security updates are mandatory and they are usually installed automatically, Linux is usually administered via SSH and there's no indication of any updates at all. In Windows most server applications can be updated seamlessly without breaking services configuration. In Linux in a lot of cases new software releases require manual reconfiguration (here are a few examples: ngnix, apache, exim, postfix). The above two causes lead to a situation when hundreds of thousands of Linux installations **never receive any updates**, because their respective administrators don't bother to update anything since they're afraid that something will break.
      
    August 2016 report from Kaspersky corroborates my thesis: in the first seven months of 2016 the number of infected Linux** servers** increased by 70%.
      
    Ubuntu, starting with version 16.04 LTS, applies security updates automatically except for the Linux kernel updates which require reboot (it can be eliminated as well but it's tricky). Hopefully other distros will follow.
  6. ! Fixed applications versions during a distro life-cycle (except Firefox/Thundebird/Chromium). Say, you use DistroX v18.10 which comes with certain software. Before DistroX 20.10 gets released some applications get updated, get new exciting features but you cannot officially install, nor use them.
  7. ! Let's expand on the previous point. Most Linux distros are made such a way you cannot upgrade their individual core components (like kernel, glibc, Xorg, Xorg video drivers, Mesa drivers, etc.) without upgrading your whole system. Also if you have brand new hardware oftentimes you cannot install current Linux distros because almost all of them (aside from rare exceptions) don't incorporate the newest kernel release, so either you have to use alpha/development versions of your distro or you have to employ various hacks in order to install the said kernel.
  8. Some people argue that one of the problems that severely hampers the progress and expansion of Linux is that Linux doesn't have a clear separation between the core system and user-space applications. In other words (mentioned throughout the article) third-party developers cannot rely on a fixed set of libraries and programming interfaces (API/ABI) - in most other OSes you can expect your application to work for years without recompilation and extra fixes - it's often not possible in Linux.
  9. No native or/and simple solutions for really simple encrypted file sharing in the local network with password authentication (Samba is not native, it's a reverse engineered SMB implementation, it's very difficult for the average Joe to manage and set up. Samba 4 reimplements so many Linux network services/daemons - it looks like a Swiss knife solution from outer space).
  10. ~~Glibc by design "leaks" memory (due to heap fragmentation). Firefox for Linux now uses its own memory allocator. KDE Konsole application uses its own memory allocation routines.~~ Neil Skrypuch posted an excellent explanation of this issue here.
  11. ! Just (Gnome) not enough (KDE) manpower (X.org) - three major Open Source projects are seriously understaffed.
  12. ! It's a major problem in the tech industry at large but I'll mention it anyways because it's serious: Linux/open source developers are often not interested in fixing bugs if they cannot easily reproduce them (for instance when your environment substantially differs from the developer's environment). This problem plagues virtually all Open Source projects and it's more serious in regard to Linux because Linux has fewer users and fewer developers. Open Source developers often don't get paid to solve bugs so there's little incentive for them to try to replicate and squash difficult to reproduce bugs.
  13. ! A galore of software bugs across all applications. Just look into KDE or Gnome bugzilla's - some bugs are now over ten years old with over several dozens of duplicates and no one is working on them. KDE/Gnome/etc. developers are busy adding new features and breaking old APIs. Fixing bugs is of course a tedious and difficult chore.
  14. ! Steep learning curve (even today you oftentimes need to use a CLI to complete some trivial or non-trivial tasks, e.g. when installing third party software).
  15. ! Incomplete or sometimes missing regression testing in the Linux kernel (and, alas, in other Open Source software too) leading to a situation when new kernels may become totally unusable for some hardware configurations (software suspend doesn't work, crashes, unable to boot, networking problems, video tearing, etc.)
  16. GUI network manager in Linux has serious problems.
  17. Poor interoperability between the kernel and user-space applications. E.g. many kernel features get a decent user-space implementation years after introduction.
  18. ! Linux security/permissions management is a bloody mess: PAM, SeLinux, Udev, HAL (replaced with udisk/upower/libudev), PolicyKit, ConsoleKit and usual Unix permissions (/etc/passwd, /etc/group) all have their separate incompatible permissions management systems spread all over the file system. Quite often people cannot use their digital devices unless they switch to a super user.
  19. No sandbox with easy to use GUI (like Sandboxie in Windows).
  20. ! CLI (command line interface) errors for user applications. All GUI applications should have a visible error representation.
  21. ! Certain Linux components have very poor documentation and lack good manuals.
  22. ! No unified widely used system for packages signing and verification (thus it becomes increasingly problematic to verify packages which are not included by your distro). No central body to issue certificates and to sign packages.
  23. There are no native antivirus solutions or similar software for Linux (**the existing ones are made for finding Windows viruses and analyzing Windows executives - i.e. they are more or less useless for Linux**). Say, you want to install new software which is not included by your distro - currently there's no way to check if it's malicious or not.
  24. !! Most Linux distributions do not audit included packages which means a rogue evil application or a rogue evil patch can easily make it into most distros, thus endangering the end user (it has happened several times already).
  25. ! Very bad backwards and forward compatibility.
    + ! Due to unstable and constantly changing kernel APIs/ABIs Linux is a hell for companies which cannot push their drivers upstream into the kernel for various reasons like their closeness (NVIDIA, ATI, Broadcom, etc.), or inability to control development or co-develop (VirtualBox/​Oracle, VMWare/​Workstation, etc.), or licensing issues (4Front Technologies/OSS).
    + Old applications rarely work in new Linux distros (glibc incompatibilities (double-free errors, memory corruption, etc.), missing libraries, wrong/new libraries versions). Abandoned Linux GUI software generally doesn't work in newer Linux distros. Most well written GUI applications for Windows 95 will work in Windows 10 (24 years of binary level compatibility).
    + New applications linked only against lib C will refuse to work in old distros (even though they are 100% source compatible with old distros).
    + New library versions bugs, regressions and incompatibilities.
    + Distro upgrade can render your system unusable (kernel might not boot, some features may stop working).
    + There's a myth that backwards compatibility is a non-issue in Linux because all the software has sources. However a lot of software just cannot be compiled on newer Linux distros due to 1) outdated, conflicting, no longer available libraries and dependencies 2) every GCC release becoming much stricter about C/C++ syntax 3) Users just won't bother compiling old software because they don't know how to 'compile' - nor they should they need to know how to do that.
    + DE developers (KDE/Gnome) routinely cardinally change UI elements, configuration, behaviour, etc.
    + Open Source developers usually don't care about application behaviour beyond their own usage scenarios. I.e. coreutils developers for no good reasons have broken head/tail functionality which is used by the Loki installer.
    + Quite often you cannot run new applications in LTS distros. Recent examples: GTK3 based software (there's no official way to use it in RHEL6), and Google Chrome (Google decided to abandon LTS distros).
  26. Linux has a 255 bytes limitation for file names (this translates to just 63 four-byte characters in UTF-8) - not a great deal but copying or using files or directories with long names from your Windows PC can become a serious challenge.
  27. (GI) Certain applications that exist both for Windows and Linux start up faster in Windows than in Linux, sometimes several times faster. It's worth noting though that SSD disk users are mostly unaffected.
  28. All native Linux filesystems (except ext4) are case sensitive about filenames which utterly confuses most users. This wonderful peculiarity doesn't have any sensible rationale. Less than 0.01% of users in the Linux world depend on this feature.
  29. (Not a big issue anymore since users are slowly migrating to SSD drives) Most Linux filesystem cannot be fully defragmented unless you compact and expand your partition which is very dangerous. Ext4fs supports defragmentation but only for individual files. You cannot combine data and turn free space into one continuous area. XFS supports full defragmentation though, but by default most distros offer Ext4 and there's no official safe way to convert ext4 to XFS.
  30. Linux preserves file creation time only for certain filesystems (ext4, NTFS, fat). Another issue is that user space utilities currently cannot view or modify this time (ext4 `debugfs` works only under root).
  31. A lot of UNIX problems (PDF, 3MB) apply to Linux/GNU as well.
  32. There's a lot of hostility in the open source community.
  33. This is so freaking "amazing", you absolutely have to read it - the developer behind XScreenSaver fought with Debian developers.
  34. Random ramblings or why you may hate Linux (some are severely outdated/irrelevant/fixed but they are left for posterity to see the innards of the open source movement and community):
      1) KDE: troubleshooting kded4 bugs.
      2) A big discussion on Slashdot as to why people still prefer Windows over Linux.
      3) Another big discussion on Slashdot as to why Linux still lacks.
      4) Any KDE plasmoid can freeze the entire KDE desktop - seems to be fixed in KDE5.
      5) Why Desktop Linux Hasn't Taken Off - Slashdot.
      6) Torvalds Slams NVIDIA's Linux Support - Slashdot.
      7) Are Open-Source Desktops Losing Competitiveness? - Slashdot (A general consensus - No).
      8) Broadcom Wi-Fi adapters under Linux are a PITA.
      9) A Gnome developer laments the state of Gnome 3 development.
      10) Fuck LTS distros: Google Says Red Hat Enterprise Linux 6 Is Obsolete (WTF?! Really?!).
      11) A rant about Gnome 3 APIs.
      12) OMFG: Ubuntu has announced Mir, an alternative to X.org/Wayland.
      13) KDE's mail client cannot properly handle IMAP mail accounts.
      14) Desktop Linux security is a mess (zipped MS Powerpoint presentation, 1.3MB) + 13 HID vulnerabilities.
      15) Yet another Gnome developer concurs that Gnome 3 was a big mistake.
      16) Gnome developers keep fucking hard their users.
      17) Fixed now: ~~KDE developers' yet another fuck up called, "You want to disable files indexing? Really? Fuck you! Eat what we're giving you."~~
      18) Linux "security" is a mess. For the past six months two local root exploits have been discovered in the Linux kernel. Six critical issues have been discovered in OpenSSL (which allow remote exploitation, information disclosure and MITM).
      19) Skype developers dropped support for ALSA. Wow, great, fuck compatibility, fuck old distros, fuck the people for whom PulseAudio is not an option.
      20) Well, fuck compatibility, there are now three versions of OpenSSL in the wild: OpenSSL itself, BoringSSL by Google, LibReSSL by OpenBSD. All with incompatible APIs/ABIs (OpenSSL itself breaks API/ABIs quite often).
      21) ~~KDE developers decided to remove support for the xembed based system tray, so your old applications will not have a system tray icon, unless you patch your system. Wonder-fuck-you-ful.~~ The feature has finally been reintroduced in Plasma 5.5.5 after two years (!!) of users' remonstrance.
      22) KDE developers/maintainers silently delete unpleasant user comments on dot.kde.org. KDE developers ignore bugs posted at bugs.kde.org.
      23) Welcome: PulseAudio emulation for Skype. Audio is not fucked up in Linux you said?
      24) UDP connections monitoring is a hell on earth.
      25) Linux has become way too complex even for ... Linux developers.
      26) Linux developers gave up on maintaining API/ABI compatibility even among modern distros and decided to bundle a full Linux stack with every app to virtualize it. This is so fxcked up, I've got no words. Oh, Wayland is required for that, so this thing is not going to take off any time soon.
      27) Out of 20 most played/popular games in Steam only three are available for Linux. I'm not saying it's bad, it's just what it is.
      28) This article is getting unwieldy but fuck it, even Linus admits that API/ABI compatibility in Linux is beyond fucked up: "making binaries for Linux desktop applications is a major fucking pain in the ass. You don’t make binaries for Linux, you make binaries for Fedora 19, Fedora 20, maybe even RHEL5 from 10 years ago. You make binaries for Debian Stable…well actually no, you don't make binaries for Debian Stable because Debian Stable has libraries that are so old that anything built in the last century doesn’t work."
      29) KDE is spiralling out of control (besides, its code quality is beyond horrible - several crucial parts of the KDE SC, like KMail/akonadi, are barely functional): people refuse to maintain literally hundreds of KDE packages.
      30) Google Chrome stopped supporting 32bit distros starting March 2016. They don't care that 64bit distros and applications in some cases require up to 40% more RAM.
      31) Let's have some fun! ... or hatred maybe? Native Linux games do ... not work under Linux. Fuck compatibility. Fuck it! This "OS" is a fucking joke.
      32) QA/QC in Linux you say? Oh, really? Like you're not joking?
      33) In April 2017 Canonical (the company behind Ubuntu) axed the development of their own desktop environment Unity and their own display manager Mir. A lot of people questioned their decision to migrate to Gnome 3 which is not perceived as a PC-friendly desktop environment by the Linux community.
      34) This is so brilliant it will leave you speechless. This is how open source projects should interact more often (it's a sad joke). KWin + Wayland vs. Qt 5.8/5.9, fight!
      35) In 2018 Gnome developers decided that applications must replace title bars with header bars.
      36) This is quite damning: Linux.com admits that there are no stable Linux kernels, "The most we can do is to unhelpfully state that they are "differently stable"".
      37) Ubuntu in its feat of idiotic brilliance decided to deprecate 32bit support in Ubuntu. After Valve decided to pull Ubuntu support in Steam, Ubuntu reneged on its decision but the damage has been done. Ubuntu/Mark Shuttleworth don't care that there are literally thousands of 32bit exceptionally useful applications including games which will never be ported to 64bit.
  
+ Software development under and for Linux
  1. ! Stable API nonsense: you cannot develop kernel drivers out of the kernel tree, because they will soon become incompatible with mainline. That's the sole reason why RHEL and other LTS distros are so popular in enterprise. This is why Google is currently developing an alternative to the Linux kernel - even they don't have enough resources and willpower to maintain their own Linux fork.
  2. Games development: no complete multimedia framework.
  3. ! Hostility towards third-party developers: many open source projects are extremely self-contained, i.e. if you try to develop your open source project using open source library X or if you try to bring your suggestions to some open source project, you'll be met with extreme hostility.
  4. A lot of points mentioned above apply to this category, they won't be reiterated.
+ Enterprise level Linux problems:
  1. Most distros don't allow you to easily set up a server with e.g. such a configuration: Samba, SMTP/POP3, Apache HTTP Auth and FTP where all users are **virtual**. LDAP is a PITA. Authentication against MySQL/any other DB is also a PITA.
  2. ! No software (group) policies.
  3. ! No standard way of software deployment (pushing software via SSH is indeed an option, but it's in no way standard, easy to use or obvious - you can use a sledgehammer to crack nuts the same way).
  4. ! No CIFS/AD level replacement/​equivalent (SAMBA doesn't count for many reasons): 1) Centralized and easily manageable user directory. 2) Simple file sharing. 3) Simple (LAN) computer discovery and browsing.
  5. *No native production-ready* filesystem with de-duplication, data and metadata checksumming and file compression (please support bcachefs - it has it all). No filesystems at all to support per-file encryption (ext4fs implements encryption for directories starting from Linux 4.1 but it will take months before desktop environments start supporting this feature).
  6. !! No proper RDP/Terminal Services alternative (built-in, standardized across distros, high level of compression, low latency, needs zero effort to be set up, integrated with Linux PAM, totally encrypted: authentication + traffic, digital signature like SSH).