#! python3
# -*- coding: utf-8 -*-

from math import floor

class CowTime:
    """
    attributes::
        __time_pool ==> 时间池，是一个列表，里面的内容为时分秒元祖(hour, min, sec)
    """
    def __init__(self, *times):
        """
        parameters::
            times ==> 若干时间对象，必须皆为长度为三，且元素皆为不小于0的整数的元祖
        """
        self.__time_pool = []
        for time in times:
            if self.__check_time(time):
                self.__time_pool.append(time)
            else:
                raise TypeError("%s: 数据错误，必须是时分秒构成的长度为3的元祖，且元素必须是不小于0的整数" % str(time))

    # 检查时间数据结构正确性
    def __check_time(self, time):
        """
        parameters::
            time ==> 要检查的时间对象
        returns::
            True ==> 时间对象数据结构合法
            False ==> 时间对象数据结构不合法
        """
        is_tuple = isinstance(time, tuple)
        is_len_three = True if len(time) == 3 else False

        if not is_tuple or not is_len_three:
            return False

        for t in time:
            is_time = True if isinstance(t, int) and t >= 0 else False
            if not is_time:
                return False

        return True

    # 向时间池中添加时间，如果时间数据结构不对，那么会抛出异常
    def add_time2pool(self, time):
        if self.__check_time(time):
            self.__time_pool.append(time)
        else:
            raise TypeError("%s: 数据错误，必须是时分秒构成的长度为3的元祖，且元素必须是不小于0的整数" % str(time))

    # 计算总秒数
    def calc_seconds(self):
        seconds = 0
        for time in self.__time_pool:
            seconds += time[0] * 3600 + time[1] * 60 + time[2]

        return seconds

    # 计算总分钟数
    def calc_minute(self):
        minutes = 0
        seconds = 0
        for time in self.__time_pool:
            minutes += time[0] * 60 + time[1] + floor(time[2] / 60)
            seconds += time[2] % 60

        minutes += floor(seconds / 60) + (seconds % 60 / 60)
        return minutes

    # 计算总小时数
    def calc_hours(self):
        hours = 0
        minutes = 0
        seconds = 0
        for time in self.__time_pool:
            hours += time[0] + floor(time[1] / 60) + floor(time[2] / 3600)
            minutes += time[1] % 60
            seconds += time[2] % 3600

        hours += floor(seconds / 3600) + floor(minutes / 60) + (seconds % 3600 / 3600) + (minutes % 60 / 60)
        return hours

    # 清空时间池
    def clear(self):
        self.__time_pool.clear()

# 测试
def main():
    time1 = (10, 8, 12)
    time2 = (3, 45, 9)
    time3 = (21, 16, 31)

    times = [time1, time2, time3]

    time_calc = CowTime()
    for i in range(len(times)):
        time_calc.add_time2pool(times[i])
        print("%d:%d:%d\r\nH: %f\r\nM: %f \r\nS: %d\r\n...................." % (
                times[i][0],
                times[i][1],
                times[i][2],
                time_calc.calc_hours(),
                time_calc.calc_minute(),
                time_calc.calc_seconds()
            )
        )
        time_calc.clear()

    times_calc = CowTime(time1, time2, time3)
    print("平均时间：\r\nH: %f\r\nM: %f\r\nS: %f" % (
            times_calc.calc_hours() / 3,
            times_calc.calc_minute() / 3,
            times_calc.calc_seconds() / 3
        )
    )

if __name__ == '__main__':
    main()
